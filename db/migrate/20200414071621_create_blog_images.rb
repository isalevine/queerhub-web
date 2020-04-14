class CreateBlogImages < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_images do |t|
      t.string :image_url
      t.string :alt_text
      t.belongs_to :blog_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
