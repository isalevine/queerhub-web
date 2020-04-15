class UserAccount < ApplicationRecord
    belongs_to :user
    
    has_many :user_account_blogs
    has_many :blogs, through: :user_account_blogs
end
