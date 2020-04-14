class UserAccountBlog < ApplicationRecord
  belongs_to :user_account
  belongs_to :blog
end
