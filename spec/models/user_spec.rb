require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject { tester }

  describe "valid user" do
    let(:tester){
      FactoryBot.build(:tester, username: "tester name",email: "tester@example.com")
    }
    it { is_expected.to be_valid }
    
    describe "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        let(:email){ valid_address}
        it { is_expected.to be_valid }
      end
    end
    
  end  
  
  
  
  describe "invalid user" do
    
    describe "username validate" do
      let(:tester){
        FactoryBot.build(:tester, username: username ,email: "tester@example.com")
      }
      
      describe "name should be present" do
        let(:username){ "  " }
        it { is_expected.to be_invalid }
      end
      
      describe "username should not be too long" do
        let(:username){"a" * 51}
        it { is_expected.to be_invalid }
      end
      
    end
    
    
    describe "email validate" do
      let(:tester){
        FactoryBot.build(:tester, username: "tester name",email: email)
      }
      describe "email should be present" do
        let(:email){ "  " }
        it { is_expected.to be_invalid }
      end
      
      describe "email should not be too long" do
        let(:email){ "a" * 244 + "@example.com" }
        it { is_expected.to be_invalid }
      end
      
      describe "email validation should reject invalid addresses" do
        invalid_emails =  %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com] 
        invalid_emails.each do | invalid_email |
          let(:email){ invalid_email }
          it { is_expected.to be_invalid }
        end
      end
      
      describe "email addresses should be unique" do
        let(:email){ "tester@example.com" }
        it "is uniqueness working?" do
          @dupulicate_user = tester.dup
          @dupulicate_user.email = tester.email.upcase
          tester.save
          expect(@dupulicate_user).to be_invalid
        end
      end
      
    end
  end
  
end

