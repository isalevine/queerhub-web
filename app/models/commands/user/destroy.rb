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

    def validate_id
      user = ::User.where(id: payload[:id])
      self.errors.add "id", "User not found" unless user.exists?
      self.errors.add "id", "User is already deleted" if user.pluck(:deleted).first
    end
  end
end
