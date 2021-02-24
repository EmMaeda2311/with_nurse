class Blog < ApplicationRecord
  validates :title, presence: true

  has_rich_text :content
  
  belongs_to :user
end
