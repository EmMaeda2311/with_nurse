class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable, :omniauthable
         
         
  validates :username, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = (/\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\Z/)
  validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }
end
