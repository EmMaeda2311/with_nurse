require 'rails_helper'


RSpec.describe 'admin_user', type: :system, use_truncation: false, js: true do
  let!(:tester){ FactoryBot.create(:tester) }
  let!(:tester2){ FactoryBot.create(:tester2) }

    scenario '管理者ユーザー' do
      valid_login(tester)
      within 'header' do
        expect(page).not_to have_content 'ログイン'
        expect(page).to have_content 'tester'
        expect(page).to have_content '管理者ページ'
      end

      click_link '管理者ページ'
      expect(page).to have_content "#{User.all.count} 人のユーザーがいます"

      expect(page).to have_selector '.user-list', text: 'tester'

      expect(page).to have_selector '.user-list', text: 'tester2'

      expect(page).to have_selector '.user-list', text: 'tester'

      expect(User.count).to eq 2

      all('.admin-delete-link').last.click
      expect(page.driver.browser.switch_to.alert.text).to eq "削除しますか？"

      page.driver.browser.switch_to.alert.accept

  
      sleep 3
      expect(User.count).to eq 1
      expect(page).to have_content "#{User.all.count} 人のユーザーがいます"

      expect(page).to have_selector '.user-list', text: 'tester'
      expect(page).not_to have_selector '.user-list', text: 'tester2'

    end

    scenario "一般ユーザー" do
      valid_login(tester2)
      within 'header' do
        expect(page).not_to have_content 'ログイン'
        expect(page).to have_content 'tester2'
        expect(page).not_to have_content '管理者ページ'
      end

      visit users_path(tester)
      expect(page).not_to have_content "#{User.all.count} 人のユーザーがいます"
      expect(page).to have_selector "#my-info",text:"マイページへ"
      expect(page).to have_selector "#my-info",text:"自分の看護を発信する"
      expect(page).to have_selector "#my-info",text:"スキルを鍛える"
    end

end
