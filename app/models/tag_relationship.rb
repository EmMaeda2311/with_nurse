class TagRelationship < ApplicationRecord

  belongs_to :blog
  belongs_to :tag

  validates :blog_id, uniqueness: {scope: :tag_id}
end
