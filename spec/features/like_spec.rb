# require 'rails_helper'

# RSpec.feature 'like', type: :feature do
#   let!(:blog) { FactoryBot.create(:blog1) }
#   let!(:tester){ blog.user }
#   let(:like) { create(:like, user_id: tester.id, blog_id: blog.id) }

#   scenario "いいねする" do
#     visit root_path
#     click_link "ログイン"
#     fill_in "メールアドレス", with: "tester1@example.com"
#     fill_in "パスワード", with: "foobar"

#     within '.actions' do
#       click_on "ログイン"
#     end

#     within 'header' do
#       expect(page).not_to have_content 'ログイン'
#       expect(page).to have_content "tester"
#     end

#     expect(page).to have_content "Test Title1"
#     click_link "Test Title1"

#     expect(page).to have_selector  'h1', text: "Test Title1"
#     expect(page).to have_content "Good Nurse"

#   end

# end