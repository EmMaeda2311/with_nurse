require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:blog) { create(:blog1) }
  let!(:tester){ blog.user }
  let(:like) { create(:like, user_id: tester.id, blog_id: blog.id) }
  describe "いいね機能" do

    it "いいねは一度だけ" do
      like = create(:like, user_id: tester.id, blog_id: blog.id)
      @dupulicate_like = build(:like, user_id: tester.id, blog_id: blog.id)
      expect(@dupulicate_like).to be_invalid
    end
  end
end
