class BlogPost < ApplicationRecord
  belongs_to :blog

  has_many :blog_images
end
