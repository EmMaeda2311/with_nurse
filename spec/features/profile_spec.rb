require 'rails_helper'

RSpec.feature 'login test', type: :feature do
  # let(:tester){ FactoryBot.create(:tester) }
  let!(:blog){ create(:blog)}
  let!(:tester){ blog.user }

  # before do
  #  tester_data = FactoryBot.create(:blog)
  # #  @tester = User.first
  # end

  scenario "profile display" do
    valid_login(tester)

    expect(page).to have_content "ログインしました。"

    within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "tester"
    end
    # expect(page).to have_content "ログイン"
    
    # visit "/users/#{tester.id}"

    expect(page).to have_link "マイページへ"
    expect(page).to have_link "スキルを鍛える"
    expect(page).to have_link "自分の看護を発信する"

    click_on "マイページへ"

    
    expect(page).to have_content "の看護記事"
    expect(page).to have_content "の看護記事 (#{tester.blogs.count})"
    expect(page).to have_content "Test Title#{tester.blogs.count}"

    expect(page).to have_selector '.pagination'
    expect(page).to have_content "Next Label"


  end

end