class Blog < ApplicationRecord
  belongs_to :user

  has_many :likes ,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  

  validates:user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  has_rich_text :content
end
