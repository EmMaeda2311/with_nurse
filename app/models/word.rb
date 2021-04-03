class Word < ApplicationRecord

  validates :name, presence: true
  validates :read, presence: true
  validates :spell, presence: true, confirmation: true
  validates :spell_confirmation, presence: true

end
