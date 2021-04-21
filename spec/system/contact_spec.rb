require 'rails_helper'


RSpec.describe 'contact', type: :system do

    let!(:tester){ FactoryBot.create(:tester) }
    

    scenario '登録ユーザーでお問い合わせができる' do
      valid_login(tester)
      
      expect(page).to have_selector 'footer',text: 'お問い合わせ'
      within 'footer' do
        click_link 'お問い合わせ'
      end

      expect(page).to have_content 'お名前'
      expect(page).to have_content '返信先メールアドレス'
      expect(page).to have_content 'お問い合わせ内容'

      fill_in 'お名前', with:"tester"
      fill_in '返信先メールアドレス', with:"tester@example.com"
      fill_in 'お問い合わせ内容', with:'お問い合わせのテストです'

      expect do
        click_button '送信'
      end.to change(Contact, :count).by(1)

      expect(page).to have_content 'お問い合わせを受け付けました'


    end

    scenario 'ゲストユーザーでお問い合わせができる' do      
      visit root_url
      expect(page).to have_selector 'footer',text: 'お問い合わせ'
      within 'footer' do
        click_link 'お問い合わせ'
      end

      expect(page).to have_content 'お名前'
      expect(page).to have_content '返信先メールアドレス'
      expect(page).to have_content 'お問い合わせ内容'

      fill_in 'お名前', with:"guest"
      fill_in '返信先メールアドレス', with:"tester@example.com"
      fill_in 'お問い合わせ内容', with:'お問い合わせのテストです'

      expect do
        click_button '送信'
      end.to change(Contact, :count).by(1)

      expect(page).to have_content 'お問い合わせを受け付けました'


    end
end