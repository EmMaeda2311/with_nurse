require 'rails_helper'

RSpec.feature 'password_reset test', type: :feature do
  # let(:tester) { FactoryBot.create(:tester) }

  background do
    ActionMailer::Base.deliveries.clear
  end

  before do
    @token = Faker::Internet.password
    tester = FactoryBot.build(:tester)
    tester.reset_password_token = Devise.token_generator.digest(self, :reset_password_token, @token)
    tester.reset_password_sent_at = Time.now
    tester.save!
  end

  scenario 'パスワード再設定用メールが送信される' do
    visit new_user_session_path
    click_link 'パスワード変更'
    expect(page).to have_content 'パスワード再設定'
    expect(page).to have_field 'user[email]'

    fill_in 'user[email]', with: "tester1@example.com"
    expect(page).to have_button 'パスワード再設定用メールを送る'

    expect { click_button 'パスワード再設定用メールを送る' }.to change { ActionMailer::Base.deliveries.size }.by(1)

    expect(page).to have_content 'メールアドレスが登録済みの場合、パスワード再設定用のメールが数分以内に送信されます。'
  end

  scenario 'パスワードリセットができる' do
    visit edit_user_password_path(reset_password_token: @token)

    expect(page).to have_content 'パスワード再設定'
    expect(page).to have_field 'user[password]'
    expect(page).to have_field 'user[password_confirmation]'

    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_button 'パスワードを変更する'

    within 'header' do
      expect(page).to have_content "tester"
      expect(page).not_to have_content 'ログイン'
    end
    expect(page).to have_content 'パスワードが正しく変更されました。'
  end

  scenario '登録のないメールアドレスではメールが送信されず、同じメッセージが表示される' do
    visit new_user_session_path
    click_link 'パスワード変更'
    expect(page).to have_content 'パスワード再設定'
    expect(page).to have_field 'user[email]'

    fill_in 'user[email]', with: 'tester@example.com'
    expect(page).to have_button 'パスワード再設定用メールを送る'

    expect { click_button 'パスワード再設定用メールを送る' }.to change { ActionMailer::Base.deliveries.size }.by(0)
    expect(page).to have_content 'メールアドレスが登録済みの場合、パスワード再設定用のメールが数分以内に送信されます。'
  end
end
