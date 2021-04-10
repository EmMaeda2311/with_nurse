class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :blogs, dependent: :destroy
  has_one :user_typing, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_blogs, through: :likes, source: :blog
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def already_liked?(blog)
    likes.exists?(blog_id: blog.id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  has_one_attached :avatar

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, #:timeoutable,
         :lockable, :omniauthable, omniauth_providers: [:google_oauth2]

  before_save { email.downcase! }
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = %r{\A[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\Z}
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :accepted, presence: { message: 'に同意してください' }
  attr_accessor :current_password

  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |user|
      user.provider = auth.provider,
                      user.uid = auth.uid,
                      user.username = auth.info.name,
                      user.email = auth.info.email,
                      user.password = Devise.friendly_token[0, 20]
      user.accepted = true
    end
  end
end
