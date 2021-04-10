require 'rails_helper'

RSpec.feature 'omniauth test', type: :feature do

  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario "未ログインユーザーのグーグルログインの成功" do
    visit new_user_session_path
    expect{
      click_link 'Googleアカウントでログイン'
    }.to change(User, :count).by(1).and change{ ActionMailer::Base.deliveries.size }.by(1)

    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)

    expect(page).to have_content "メールアドレスが確認できました。"    
    expect(page).to have_content "ログアウト" 
    expect(page).to have_content "メールアドレスが確認できました。"     

  end


  scenario "google認証サインアップ済みユーザーの場合、ユーザーが増えない" do
    visit new_user_session_path
    click_link 'Googleアカウントでログイン'

    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)

    within "header" do
      click_link 'ログアウト'
    end
    
    click_link 'ログイン'
    expect{
      click_link 'Googleアカウントでログイン'
    }.not_to change(User, :count)

    expect(page).to have_selector "header", text: 'ログアウト'
    expect(page).to have_content 'Google_oauth2 アカウントによる認証に成功しました。'

  end


  scenario "omniauth user successful edit" do
    visit new_user_registration_path
    click_link 'Googleアカウントでログイン'

    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)

    within "header" do
      click_link 'プロフィール変更'
    end

    expect(page).not_to have_field "user[password]"
    expect(page).not_to have_field "user[current_password]"

    fill_in "user[username]", with: "update_tester"
    click_button "プロフィール変更"

    expect(page).to have_content "アカウント情報を変更しました。"

    within 'header' do
     expect(page).to have_content "update_tester"
   end
      
  end

end