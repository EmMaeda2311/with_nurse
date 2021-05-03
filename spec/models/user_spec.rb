require 'rails_helper'

RSpec.describe User, type: :model do
  subject { tester }
  let(:tester) { FactoryBot.build(:tester, username: 'tester') }

  describe 'valid user' do
    it { is_expected.to be_valid }

    describe 'email validation should accept valid addresses' do
      let(:tester) { build(:tester) }

      it "valid email format" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          tester.email = valid_address
          expect(tester).to be_valid
        end
      end
    end
  end

  describe 'invalid user' do
    describe 'username validate' do
      describe 'name should be present' do
        let(:tester) { build(:tester, username: '  ') }
        it { is_expected.to be_invalid }
      end

      describe 'username should not be too long' do
        let(:tester) { build(:tester, username: 'a' * 51) }
        it { is_expected.to be_invalid }
      end
    end

    describe 'email validate' do
      describe 'email should be present' do
        let(:tester) { build(:tester, email: ' ') }
        it { is_expected.to be_invalid }
      end

      describe 'email should not be too long' do
        let(:tester) { build(:tester, email: 'a' * 244 + '@example.com') }
        it { is_expected.to be_invalid }
      end

      describe 'email validation should reject invalid addresses' do
        let(:tester) { build(:tester) }
        
          it "invalid email format" do
            invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
            invalid_emails.each do |invalid_email|
              tester.email = invalid_email
              expect(tester).to be_invalid
            end
          end
      end

      describe 'email addresses should be unique' do
        it 'is uniqueness working' do
          @dupulicate_user = tester.dup
          @dupulicate_user.email = tester.email.upcase
          tester.save
          expect(@dupulicate_user).to be_invalid
        end
      end
    end

    describe 'password validate' do
      describe 'password should be present' do
        let(:tester) { build(:tester, password: '' * 6) }
        it { is_expected.to be_invalid }
      end

      describe 'password should have a minimum length' do
        let(:tester) { build(:tester, password: 'a' * 5) }
        it { is_expected.to be_invalid }
      end
    end

    describe "accepted check box" do
      describe "check accepted" do
      let(:tester){ build(:tester, accepted: false)}
      it {is_expected.to be_invalid}
      end
    end
  end
end
