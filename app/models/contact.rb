class Contact < ApplicationRecord


  VALID_EMAIL_REGEX = %r{\A[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\Z}
  validates :email, presence: true, length: {maximum:255},
                  format:{with: VALID_EMAIL_REGEX}
  validates :message, presence: true

end
