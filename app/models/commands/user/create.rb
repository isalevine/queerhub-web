# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/commands/todo_item/create.rb

# TODO: Add validations for data
module Commands
  class User::Create
    include Mixins::Command

    attributes :payload
    # TODO: add => validate :validate_name, :validate_email

    private def build_event
      encrypt_payload_password
      Events::User::Created.new(
        payload: payload
      )
    end

    # Salts the password to avoid storing it as plaintext in the event payload
    # (This means that the User model does NOT include has_secure_password)
    private def encrypt_payload_password
      payload["password"] = BCrypt::Password.create(payload["password"])
    end

  end
end
