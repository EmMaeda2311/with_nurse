require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:blog){FactoryBot.build(:blog1)}


  describe "valid tag" do
    
    it "ブログを投稿するとタグが保存される" do
      expect{blog.save}.to change{Tag.count}.by(2)
    end
  end
end
