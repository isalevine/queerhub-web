# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/lib/command.rb
  
# The Base command mixin that commands include.
#
# A Command has the following public api.
#
# ```
#   MyCommand.call(user: ..., post: ...) # shorthand to initialize, validate and execute the command
#   command = MyCommand.new(user: ..., post: ...)
#   command.valid? # true or false
#   command.errors # +> <ActiveModel::Errors ... >
#   command.call # validate and execute the command
# ```
#
# `call` will raise an `ActiveRecord::RecordInvalid` error if it fails validations.
#
# Commands including the `Command::Base` mixin must:
# * list the attributes the command takes
# * implement `build_event` which returns a non-persisted event or nil for noop.
#
# Ex:
#
# ```
#   class MyCommand
#     include Command
#
#     attributes :user, :post
#
#     def build_event
#       Event.new(...)
#     end
#   end
# ```

module Mixins
  module Command
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
    end

    class_methods do
      # Run validations and persist the event.
      #
      # On success: returns the event
      # On noop: returns nil
      # On failure: raise an ActiveRecord::RecordInvalid error
      def call(*args)
        new(*args).call
      end

      # Define the attributes.
      # They are set when initializing the command as keyword arguments and
      # are all accessible as getter methods.
      #
      # ex: `attributes :user_id, :payload`
      def attributes(*args)
        attr_reader(*args)

        initialize_method_arguments = args.map { |arg| "#{arg}:" }.join(", ")
        initialize_method_body = args.map { |arg| "@#{arg} = #{arg}" }.join(";")

        class_eval <<~CODE
          def initialize(#{initialize_method_arguments})
            #{initialize_method_body}
            after_initialize
          end
        CODE
      end
    end

    def call
      return nil if event.nil?
      raise "The event should not be persisted at this stage!" if event.persisted?

      validate!
      execute!

      event
    end

    def validate!
      valid? || raise(Activeecord::RecordInvalid, self)
    end

    # A new record, or nil if noop
    def event
      @event ||= build_event
    end

    private def execute!
      event.save!
    end
    
    # Returns a new event record, or nil if noop
    private def build_event
      raise NotImplementedError
    end

    private def valid_payload_values?
      payload.each do |key, value|
        self.send "validate_#{key}", value if self.respond_to?("validate_#{key}")
      end
    end

    # Hook to set default values
    private def after_initialize
      # noop
    end

  end
end
