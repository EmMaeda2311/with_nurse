require 'rails_helper'

RSpec.describe 'like', type: :system do

  before do
    @blog = FactoryBot.create(:blog) 
    tester = FactoryBot.create(:tester)
    @like = create(:like,user_id:tester.id, blog_id:@blog.id)
    valid_login(tester)
  end

  scenario "いいねする", use_truncation: false, js:true do

    within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "tester"
    end

    expect(page).to have_content "Test Title 0"
    within first('.blog-title') do
      click_link "Test Title 0"
    end
    expect(page).to have_selector  'h1', text: "Test Title 0"
    expect(page).to have_content "Good Nurse 0"
    
    find(".like").click
    
    expect(page).to have_content "Good Nurse 1"
    expect(page).not_to have_content "Good Nurse 0"

  end

end