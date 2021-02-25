class Blog < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  # validates :title, presence: true
  has_rich_text :content
end
