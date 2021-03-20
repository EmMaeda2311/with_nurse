class Blog < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships

  

  validates:user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  has_rich_text :content

  def save_tags(save_blog_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - save_blog_tags
    new_tags = save_blog_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      blog_tag = Tag.find_or_create_by(name: new_name)
      self.tags << blog_tag
    end
  end

end
