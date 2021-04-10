require 'rails_helper'
require 'date'

RSpec.describe 'blog interface', type: :system do
  let!(:blog) { create(:blog) }
  let!(:blog2) { create(:blog2) }
  let!(:tester) { blog.user }
  let!(:tester2) { blog2.user }

  scenario 'ブログ新規投稿', use_truncation: false, js: true do
    valid_login(tester)

    within 'header' do
      expect(page).not_to have_content 'ログイン'
      expect(page).to have_content 'tester'
    end

    expect(page).to have_content 'みんなの看護'
    expect(all('div.users-blog').size).to eq(10)

    click_link '自分の看護を発信する'
    expect(page).to have_content '新規作成'
    expect(page).to have_content 'タイトル'
    expect(page).to have_content '本文'
    expect(page).to have_css 'trix-editor'

    fill_in 'タイトル', with: 'test title'
    fill_in_rich_text_area 'blog_content', with: 'testだよ'

    click_button '作成'

    expect(page).to have_content '「test title」 を投稿しました'
  end

  scenario 'ブログの変更画面と詳細ページの表示とタグ検索', use_truncation: false, js: true do
    valid_login(tester)
    day = blog.created_at
    blog_time = day.strftime('%Y年%m月%d日')

    expect(page).to have_content 'みんなの看護'
    expect(page).to have_content blog.title
    expect(page).to have_content "#{blog_time} に投稿"

    expect(page).to have_selector '.users-blog', text: 'tester'

    first('.edit-icon').click

    expect(page).to have_content '記事編集'
    expect(page).to have_field 'タイトル', with: blog.title
    # expect(page).to have_field "blog_content"

    fill_in 'タイトル', with: '変更後のタイトル'
    fill_in 'タグをつける。複数つけるには’,’で区切ってください。　例: 循環器,救急看護', with: 'test-tag1,test-tag2,　, 半角スペース,test-tag1'
    click_button '編集'

    # ブログ記事の詳細ページの表示
    # expect(page).to have_content "変更後のタイトル"
    # expect(page).to have_link "編集"#画像リンク
    find('.edit-icon')
    find('.delete-link')
    # expect(page).to have_link "削除"

    expect(page).to have_selector '.tag-list', text: 'test-tag1'
    expect(page).to have_selector '.tag-list', text: 'test-tag2'
    expect(page).to have_selector '.tag-list', text: '半角スペース'
    expect(page).not_to have_selector '.tag-list', text: '　'
  end

  scenario 'ブログの一覧ページの表示とテキスト検索' do
    visit root_url
    click_link 'みんなの看護を見る'

    expect(page).to have_content "#{Blog.all.count} 件の看護が投稿されています"

    expect(all('div.users-blog').size).to eq(30)
    expect(page).to have_selector 'div.pagination'

    fill_in 'search', with: 'Test Title 2'
    click_button '検索'

    expect(page).to have_content '3 件の看護が投稿されています'
  end

  scenario '未ログインユーザーでもブログ記事は見れる' do
    visit root_url
    click_link 'みんなの看護を見る'

    expect(page).to have_content "#{Blog.all.count} 件の看護が投稿されています"

    within first('.blog-title') do
      click_link 'Test Title 2'
    end

    expect(page).to have_selector 'h1', text: 'Test Title 2'
  end

  scenario 'ブログから別ユーザーのマイページが閲覧できる' do
    valid_login(tester)

    expect(page).to have_content 'tester2'

    within first('.users-blog') do
      click_link 'tester2'
    end

    expect(page).to have_content 'tester2さんの看護'
    expect(page).to have_content tester2.blogs.count.to_s
  end

  # scenario "他ユーザーのブログは編集削除リンクが表示されていない" do
  #   valid_login(tester2)
  #   within 'header' do
  #     expect(page).not_to have_content 'ログイン'
  #     expect(page).to have_content "tester2"
  #   end

  #   expect(page).to have_content "みんなの看護"
  #   expect(all('div.users-blog').size).to eq(10)
  #   expect(page).to have_selector 'div.user', text: 'tester2'
  #   expect(page).to have_selector 'div.user', text: 'tester'

  #   expect(page).to have_link "編集"#画像リンク
  #   expect(page).to have_link "削除"
  #   # expect('tester2'.size).to eq(10)
  #   expect('div.delete-link'.size).to eq(28)
  # end
end
