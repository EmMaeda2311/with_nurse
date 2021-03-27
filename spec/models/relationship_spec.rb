require 'rails_helper'
RSpec.describe Relationship, type: :model do

  let(:tester) {create(:tester)}
  let(:tester2) { create(:tester2)}
  let(:active) {tester.active_relationships.build(followed_id: tester2.id)}
  subject {active}

  it { should be_valid }

  describe "follower,followed methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }

    it "follower method return following-user" do
      expect(active.follower).to eq tester
    end

    it "followed method return follower-user" do
      expect(active.followed).to eq tester2
    end
  end

  describe "validate" do
    it "フォロワーが存在している" do
      active.follower = nil
      expect(active).to be_invalid 
    end

    it "フォローされる人がいる" do
      active.followed = nil
      expect(active).to be_invalid 
    end
  end

  describe "フォローできるか" do

    it "まだフォローしていないこと" do
      expect(tester.following?(tester2)).to be_falsey
    end
    
    it "フォロー中になること" do
      tester.follow(tester2)
      expect(tester.following?(tester2)).to be_truthy
    end
    
    it "フォローを解除できる" do
      tester.follow(tester2)
      tester.unfollow(tester2)
      expect(tester.following?(tester2)).to be_falsey
    end
  end
end
