require 'rails_helper'

RSpec.feature 'login test', type: :feature do
  let(:tester){ FactoryBot.create(:tester) }
  
  scenario "login with valid information" do
    valid_login(tester)
    within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "tester"
    end
    expect(page).to have_content 'ログインしました。'
  end
  
  scenario "
  open page you were trying to open after logging in" do
    
    visit "/users/#{tester.id}"
    expect(page).to have_content "アカウント登録もしくはログインしてください。"
    expect(page).to have_field "user[email]"
    expect(page).to have_field "user[password]"
    
    fill_in "メールアドレス", with: tester.email
    fill_in "パスワード", with: tester.password
    click_button "ログイン"
    
     within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "tester"
    end
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content 'Users#show'
    
    
  end
  
  


end