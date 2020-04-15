class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :description
      t.text :content
      t.string :status
      t.belongs_to :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
