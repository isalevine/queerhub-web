class User < ApplicationRecord
    # TODO: add manual auth using BCrypt::Password.new on password_digest
    # https://stackoverflow.com/a/24922565
    
    # has_secure_password
    
    has_many :user_accounts
    has_many :user_roles
    has_many :roles, through: :user_roles

    has_many :events
end
