class CreateUserAccountBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_account_blogs do |t|
      t.belongs_to :user_account, null: false, foreign_key: true
      t.belongs_to :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
