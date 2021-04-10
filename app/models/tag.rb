class Tag < ApplicationRecord
  before_validation :delete_space

  has_many :tag_relationships, dependent: :destroy
  has_many :blogs, through: :tag_relationships

  validates :name, uniqueness: { case_sensitive: true }

  private

  def delete_space
    self.name = name.strip
  end
end
