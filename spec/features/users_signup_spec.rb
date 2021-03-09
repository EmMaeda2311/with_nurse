require 'rails_helper'

RSpec.feature 'signup test' do
  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario "valid signup information" do
    visit new_user_registration_path
    
    fill_in "user[username]", with: "Example User"
    fill_in "user[email]", with: "tester@example.com"
    fill_in "user[password]", with: "password"
    check   'user[accepted]'
    
    expect{
      click_button "新規登録"
    }.to change(User, :count).by(1).and change{ ActionMailer::Base.deliveries.size }.by(1)

    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    
    
    within '.nav-menu' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "Example User"
    end

    expect(page).to have_content 'メールアドレスが確認できました。'
  end
  
  
  scenario "invalid signup infomation" do
   visit new_user_registration_path
   
   expect{
     click_button "新規登録"
   }.to change(User, :count).by(0)
   
   blank_error_messages = %w[アカウント名 が入力されていません メールアドレス が入力されていません。 メールアドレス は有効でありません。 パスワード が入力されていません。 パスワード は6文字以上に設定して下さい。]
  #  利用規約、及び、個人情報の取扱 に同意してください
   
   blank_error_messages.each do |blank_error_message|
    expect(page).to have_content blank_error_message
   end
   
   
    fill_in "user[username]", with: "Example User"
    fill_in "user[email]", with: "tester@example.com"
    fill_in "user[password]", with: "foo"
    check   'user[accepted]'
    
    expect{
     click_button "新規登録"
    }.to change(User, :count).by(0)
    
    expect(page).to have_content "パスワードは6文字以上に設定して下さい。"
    expect(page).not_to have_field 'user[password]', with: "foo"

  end
end