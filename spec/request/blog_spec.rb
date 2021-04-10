require 'rails_helper'

RSpec.describe "Blogs" ,type: :request do

  let(:blog) { create(:blog) }
  let(:blog1) { build(:blog1)}
  let!(:tester){ blog.user }

  describe "ログインユーザーではない" do
    
    it "新規投稿をリクエストしてもログインを要求される" do
        get new_blog_path
        expect(response).to redirect_to( new_user_session_path )
    end

    it "なんとかPOSTしてみても、投稿されない" do
      expect{ post blogs_path, params:{ blog: {title:"test", content:"error text"}} }.to change{ tester.blogs.count }.by(0)
    end

    it "削除しようとするとログインを要求される" do
      delete blog_path(blog)
      expect(response).to redirect_to( new_user_session_path )
    end

    it "edit blog page request 302" do
      get edit_blog_path(blog)
      expect(response).to have_http_status( 302 )
    end

    it "update blog but not update" do
      patch blog_path(blog), params:{ blog: {title:"test2",content:"text2"}}
      expect(blog.reload.title).not_to eq("test2")
    end

    it "blogs index page request 200" do
      get blogs_path
      expect(response).to have_http_status( 200 )
    end
  end





  describe "ログインユーザー" do
    
    before do
      login_as tester
    end
    
    it "testerを削除すると、testerのblogが削除されること" do
      expect{ tester.destroy }.to change{ tester.blogs.count }.by(-tester.blogs.count)
    end

    it "blog new page request 200" do
      get new_blog_path
      expect(response).to have_http_status( 200 )
    end

    it "post blog" do
      expect{ post blogs_path, params:{ blog: {title:"test", content:"text",tag_ids:"tag1,tag2"}} }.to change{ tester.blogs.count }.by(1)
    end

    it "edit blog page request 200" do
      get edit_blog_path(blog)
      expect(response).to have_http_status( 200 )
    end

    it "update blog" do
      patch blog_path(blog), params:{ blog: {title:"test2",content:"text2",tag_ids:"tag1"}}
      expect(blog.reload.title).to eq("test2")
    end

    it "delete blog" do
      expect{ delete blog_path(blog) }.to change{ tester.blogs.count }.by(-1)
    end

  end

end