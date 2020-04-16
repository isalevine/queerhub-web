class Events::User::Created < Events::User::BaseEvent
  payload_attributes :name, :email, :password

  def apply(user)
    user.name = name
    user.email = email
    user.password = BCrypt::Password.create(password)

    user
  end
end