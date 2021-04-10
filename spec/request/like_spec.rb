require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:blog) { create(:blog1) }
  let!(:tester) { blog.user }
  let(:like) { create(:like, user_id: tester.id, blog_id: blog.id) }

  describe 'ログインユーザー' do
    before do
      login_as tester
    end

    it 'いいねしていない場合、いいねできる' do
      expect do
        post api_likes_path(blog_id: blog.id, user_id: tester.id), xhr: true
      end.to change(Like, :count).by(1)
    end

    it 'いいねしている場合、いいねを取り消せる' do
      like = create(:like, user_id: tester.id, blog_id: blog.id)
      expect do
        delete api_like_path(blog_id: blog.id, user_id: tester.id, id: like.id), xhr: true
      end.to change(Like, :count).by(-1)
    end
  end
end
