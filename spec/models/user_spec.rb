require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject { tester.valid? }

  describe "valid user" do
    let(:tester) {User.new( username: "tester name",email: "tester@example.com") }
    it { is_expected.to be_truthy }
  end  
  
  describe "invalid user" do
    
    describe "username validate" do
      let (:tester){ User.new(username: username, email: "tester@example.com" ) }
      
      describe "name should be present" do
        let(:username){ "  " }
        it { is_expected.not_to be_truthy }
      end
      
      describe "username should not be too long" do
        let(:username){"a" * 51}
        it { is_expected.not_to be_truthy }
      end
      
    end
    
    
    describe "email validate" do
      let(:tester){ User.new( username: "testername", email: email)}
      
      describe "email should be present" do
        let(:email){ "  " }
        it { is_expected.not_to be_truthy }
      end
      
      describe "email should not be too long" do
        let(:email){ "a" * 244 + "@example.com" }
        it { is_expected.not_to be_truthy }
      end
      
      describe "email validation should reject invalid addresses" do
        invalid_email =  %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com] 
        invalid_email.each do | invalid_email |
          let(:email){ invalid_email }
          it { is_expected.not_to be_truthy }
        end
      end
    end
    
  end
  
end

