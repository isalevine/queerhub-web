class Events::User::BaseEvent < Events::BaseEvent
  # https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/events/todo_item/base_event.rb

  self.table_name = "user_events"

  belongs_to :user, class_name: "::User"
end