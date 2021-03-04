require 'rails_helper'

RSpec.describe "Blogs" ,type: :request do

  let(:blog) { create(:blog) }
  let!(:tester){ blog.user }

  describe "ログインユーザーではない" do
    
    it "新規投稿をリクエストしてもログインを要求される" do
        get new_blog_path
        expect(response).to redirect_to ( new_user_session_path )
    end

    it "なんとかPOSTしてみても、投稿されない" do
      expect{ post blogs_path, params:{ blog: {title:"test", content:"error text"}} }.to change{ tester.blogs.count }.by(0)
    end

    it "削除しようとするとログインを要求される" do
      delete blog_path(blog)
      expect(response).to redirect_to ( new_user_session_path )
    end
  end





  describe "ログインユーザー" do
    
    before do
      sign_in tester
    end
    
    it "testerを削除すると、testerのblogが削除されること" do
      expect{ tester.destroy }.to change{ tester.blogs.count }.by(-tester.blogs.count)
    end

    it "新規投稿画面" do
      get new_blog_path
      expect(response).to have_http_status ( 200 )
    end

    it "ブログ投稿" do
      expect{ post blogs_path, params:{ blog: {title:"test", content:"text"}} }.to change{ tester.blogs.count }.by(1)
    end

    it "ブログ削除" do
      delete blog_path(blog)
      expect(response).to have_http_status(204)
    end

  end

end