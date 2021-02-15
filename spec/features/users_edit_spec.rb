require 'rails_helper'

RSpec.feature "edit test", type: :feature do
  let(:tester){ FactoryBot.create(:tester) }
  let(:another_tester){FactoryBot.create(:another_tester)}
  
  before do 
    valid_login(tester)
  end
  
  scenario "miss edit" do
    visit edit_user_registration_path
    
    # ユーザー名とメールアドレスに現在のユーザー名とパスワードが表示されている
    expect(page).to have_field "user[username]", with: tester.username
    expect(page).to have_field "user[email]", with: tester.email
    expect(page).to have_field "user[current_password]"
    
    
    # ユーザーネーム、メールアドレス、現在のパスワードが空白でエラーを表示する
    fill_in "user[username]", with: "　　　"
    fill_in "user[email]", with: "　　　"
    
    click_button "プロフィール変更"
    blank_error_messages = %w[ユーザー名 が入力されていません メールアドレス が入力されていません。 メールアドレス は有効でありません。 現在のパスワード が入力されていません。]
    blank_error_messages.each do |blank_error_message|
      expect(page).to have_content blank_error_message
    end
    
    fill_in "user[username]", with: tester.username
    fill_in "user[email]", with: tester.email
    fill_in "user[current_password]", with: "foo"
    click_button "プロフィール変更"
    
    expect(page).to have_content "現在のパスワードが違います。"
  
  end
  
  scenario "successful edit" do
    visit edit_user_registration_path
    fill_in "user[username]", with: "update_tester"
    fill_in "user[email]", with: tester.email
    fill_in "user[current_password]", with: "foobar"
    click_button "プロフィール変更"
    
    expect(page).to have_content "アカウント情報を変更しました。"
     within 'header' do
      expect(page).to have_content "update_tester"
    end
  end
  
  scenario "guest_user login request" do
    click_link "ログアウト"
    expect(page).to have_content "ログアウトしました。"
    
    visit edit_user_registration_path
    expect(page).to have_content "アカウント登録もしくはログインしてください。"
    expect(page).to have_field "user[email]"
    expect(page).to have_field "user[password]"
    
  end
  

end