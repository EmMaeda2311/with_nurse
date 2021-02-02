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
  
end