require 'rails_helper'

RSpec.describe Word, type: :model do
  subject{ word }

  let(:word){FactoryBot.build(:word)}

  describe "valid word" do
    it { is_expected.to be_valid }
  end
  
  describe "word name presence" do
    let(:word){ build(:word, name: "  " ) }
    it { is_expected.to be_invalid }
  end

  describe "word read presence" do
    let(:word){ build(:word, read: "  " ) }
    it { is_expected.to be_invalid }
  end
  
  describe "word spell presence" do
    let(:word){ build(:word, spell: "  " ) }
    it { is_expected.to be_invalid }
  end
  
  describe "word spell_confirmation presence" do
    let(:word){ build(:word, spell_confirmation: "  " ) }
    it { is_expected.to be_invalid }
  end
  
  describe "word spell confirmation mismatch" do
    let(:word){ build(:word, spell_confirmation: "mismatch-spell" ) }
    it { is_expected.to be_invalid }
  end
end
