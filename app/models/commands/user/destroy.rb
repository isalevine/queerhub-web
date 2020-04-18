# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/commands/todo_item/create.rb

# TODO: Add validations for data
module Commands
  class User::Destroy
    include Mixins::Command

    attributes :payload
    validate :valid_payload_values?


    private

    def build_event
      Events::User::Destroyed.new(
        user_id: payload[:id],
        payload: payload
      )
    end

    def valid_payload_values?
      payload.each do |key, value|
        self.send "validate_#{key}", value
      end
    end

    def validate_id(id)
      user = ::User.find_by(id: id)
      self.errors.add "id", 'User not found' if user.nil?
      self.errors.add "id", 'User is already deleted' if user&.deleted?
    end

  end
end
