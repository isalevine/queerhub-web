class Blog < ApplicationRecord
    has_many :user_account_blogs
    has_many :user_accounts, through: :user_account_blogs
end
