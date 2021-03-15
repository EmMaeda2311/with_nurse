# require 'rails_helper'

# RSpec.feature 'blog interface', type: :feature do
#   let(:blog) { create(:blog1) }
#   let!(:tester){ blog.user }
#   let(:like) { create(:like, user_id: tester.id, blog_id: blog.id) }

#   scenario "いいねする" do
#     valid_login(tester)
#     click_link "Test Title1"

#     expect(page).to have_selector  'h1', text: "Test Title1"
#     visit blog_path(blog)

#     expect(page).to have_content "Good Nurse"

#   end

# end