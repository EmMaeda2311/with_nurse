require 'rails_helper'

RSpec.feature 'signup test' do
  scenario "valid signup information" do
    visit new_user_registration_path
    
    fill_in "user[username]", with: "Example User"
    fill_in "user[email]", with: "tester@example.com"
    fill_in "user[password]", with: "password"
    check   'user[accepted]'
    expect{
      click_button "新規登録"
    }.to change(User, :count).by(1)
    
    within '.nav-menu' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "Example User"
    end
  end
  
  
  scenario "invalid signup infomation" do
   visit new_user_registration_path
   
   expect{
     click_button "新規登録"
   }.to change(User, :count).by(0)
   
   blank_error_messages = %w[ユーザー名 が入力されていません メールアドレス が入力されていません。 メールアドレス は有効でありません。 パスワード が入力されていません。 パスワード は6文字以上に設定して下さい。 利用規約、及び、個人情報の取扱 に同意してください]
   
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
    
    expect(page).to have_content "パスワード は6文字以上に設定して下さい。"
    expect(page).not_to have_field 'user[password]', with: "foo"

  end


  scenario "未ログインユーザーのグーグルログインの成功" do
    visit new_user_registration_path
    expect{
      click_link 'GoogleOauth2 でログインする'
      sleep 1
  }.to change(User, :count).by(1)
  end

end