require 'rails_helper'

feature 'signup test' do
  scenario "valid signup information" do
    visit new_user_registration_path
    
    fill_in "user[username]", with: "Example User"
    fill_in "user[email]", with: "tester@example.com"
    fill_in "user[password]", with: "password"
    
    expect{
      click_button "新規登録"
    }.to change(User, :count).by(1)
    
    within '.nav-menu' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "Example User"
    end
  end
end