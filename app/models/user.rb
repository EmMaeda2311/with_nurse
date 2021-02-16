class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable,
         :lockable, :omniauthable, omniauth_providers: [:google_oauth2]
        
  
  before_save {email.downcase!}
  validates :username, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\Z/
  validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6},allow_nil: true
  # validates :accepted, presence:{message: 'に同意してください'}

  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |user|
      user.provider = auth.provider,
      user.uid = auth.uid,
      user.username = auth.info.name,
      user.email = auth.info.email,
      user.password = Devise.friendly_token[0, 20]
    end
  end

end

