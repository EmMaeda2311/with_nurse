require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  subject{ contact }
  let(:contact){FactoryBot.build(:contact)}

  describe 'validate contact' do
    it {is_expected.to be_valid}
  end



  
  describe 'email presence' do
    let(:contact){FactoryBot.build(:contact, email: "")}
    it {is_expected.to be_invalid}
  end
  
  describe 'email format invalid' do
    let(:contact){FactoryBot.build(:contact, email: "test@example,com")}
    it {is_expected.to be_invalid}
  end
  
  describe 'message presence' do
    let(:contact){FactoryBot.build(:contact, message: "")}
    it {is_expected.to be_invalid}
  end


end
