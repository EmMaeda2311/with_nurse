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

    it "testerを削除すると、testerのblogが削除されること" do
      expect{ tester.destroy }.to change{ tester.blogs.count }.by(-tester.blogs.count)
    end

  end

end