require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:blog) { create(:blog1) }
  let!(:tester){ blog.user }
  let(:like) { create(:like, user_id: tester.id, blog_id: blog.id) }

  it "いいねは一度だけ" do
    @dupulicate_like = like
    expect{@dupulicate_like.save}.to change{ Like.count }.by(0)
  end
end
