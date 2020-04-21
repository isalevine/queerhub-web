# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/commands/todo_item/create.rb

# TODO: Add validations for data
module Commands
  class User::Destroy
    include Mixins::Command

    attributes :payload
    validate :validate_id


    private

    def build_event
      Events::User::Destroyed.new(
        user_id: payload[:id],
        payload: payload
      )
    end

    # Should these validations be moved to the Event layer?
    # (as part of returning nil from a noop .call)
    def validate_id
      user = ::User.find_by(id: payload[:id])
      self.errors.add "id", 'User not found' if user.nil?
      self.errors.add "id", 'User is already deleted' if user&.deleted?
    end

  end
end
