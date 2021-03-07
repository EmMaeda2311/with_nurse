require 'rails_helper'
require 'date'

RSpec.feature 'blog interface', type: :feature do
  let!(:blog){ create(:blog)}
  let!(:tester){ blog.user }

  scenario "new post blog" do
    valid_login(tester)

    within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content "tester"
    end
    
    
    # expect(page).to have_content ""


    click_link "自分の看護を発信する"
    expect(page).to have_content "新規作成"
    expect(page).to have_content "タイトル"
    expect(page).to have_content "本文"
    expect(page).to have_css "trix-editor"
    
    fill_in "blog[title]", with: "test title"
    # fill_in_rich_text_area "blog_content" ,with: "testだよ"

    click_button "作成"

    expect(page).to have_content "本文を入力してください"

  end

  scenario "ブログの変更画面" do
    valid_login(tester)
    day = blog.created_at
    blog_time = day.strftime("%Y年%m月%d日")

    expect(page).to have_content "みんなの看護"
    expect(page).to have_content blog.title
    expect(page).to have_content "#{blog_time} に投稿"

    
    within first('.edit-icon') do
      click_link "編集"
    end

    expect(page).to have_content "記事編集"
    expect(page).to have_field "blog_title", with: blog.title
    # expect(page).to have_field "blog_content"

    

  end

end