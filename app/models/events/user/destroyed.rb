class Events::User::Destroyed < Events::User::BaseEvent
  payload_attributes :id

  def apply(user)
    byebug
    user.deleted = true

    user
  end
end