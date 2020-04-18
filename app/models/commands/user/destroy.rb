# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/commands/todo_item/create.rb

# TODO: Add validations for data
module Commands
  class User::Destroy
    include Mixins::Command

    attributes :payload

    private def build_event
      Events::User::Destroyed.new(
        user_id: payload[:id],
        event_type: "Destroyed",
        payload: payload
      )
    end

    def noop?

    end
  end
end