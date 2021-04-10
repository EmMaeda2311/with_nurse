require 'rails_helper'

RSpec.describe 'Relationship', type: :system do
  before do
    @tester = FactoryBot.create(:tester)
    @tester2 = FactoryBot.create(:tester2)
    valid_login(@tester)

    # testerはtester2をフォローする
    @tester.active_relationships.create(followed_id: @tester2.id)
  end

  scenario 'フォローユーザー一覧ページ' do
    visit following_user_path(@tester)
    expect(page).to have_content @tester.username
    expect(page).to have_selector 'h3', text: 'フォロー'
    expect(page).to have_selector '.user-list', text: @tester2.username.to_s
    expect(page).to have_selector '.user-list'
  end

  scenario 'フォロワーユーザー一覧ページ' do
    visit followers_user_path(@tester)
    expect(page).to have_content @tester.username
    expect(page).to have_selector 'h3', text: 'フォロワー'
    expect(page).to have_selector '.my-status', text: '1'
    expect(page).not_to have_selector '.user-list'
  end

  scenario '別ユーザーのフォロー/フォロワー一覧は見れないこと' do
    visit followers_user_path(@tester2)
    expect(current_path).to eq root_path
    visit following_user_path(@tester2)
    expect(current_path).to eq root_path
  end

  scenario '他のユーザーをフォロー解除', use_truncation: false, js: true do
    visit user_path(@tester2)
    expect(page).to have_selector 'h3', text: "#{@tester2.username}さんの看護"
    expect(page).to have_selector '.my-status', text: '1'

    expect(page).to have_button 'フォロー中'
    click_button 'フォロー中'
    sleep 3
    expect(page).not_to have_selector '.my-status', text: '1'
    expect(page).to have_content 'フォロー'

    expect(page).to have_button 'フォロー'
    click_button 'フォロー'

    sleep 3
    expect(page).to have_selector '.my-status', text: '1'
    expect(page).to have_button 'フォロー中'
  end
end
