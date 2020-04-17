class Events::User::Destroyed < Events::User::BaseEvent
  def apply(user)
    user.deleted = true

    user
  end
end