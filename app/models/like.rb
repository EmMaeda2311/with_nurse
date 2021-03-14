class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates_uniqueness_of :blog_id, scope: :user_id

  scope :filter_by_blog, ->(blog_id) { where(blog_id: blog_id) if blog_id }
end
