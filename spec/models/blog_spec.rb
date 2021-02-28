require 'rails_helper'

RSpec.describe Blog, type: :model do
  

  subject { blog }
  let(:blog){FactoryBot.build(:blog)}

  describe "valid blog" do
    it { is_expected.to be_valid }
  end

  describe "invalid blog" do

    describe "user_id be present" do
      let(:blog){FactoryBot.build(:blog, user_id:nil)}
      it { is_expected.to be_invalid }
    end
  
    describe "title blank" do
      let(:blog){FactoryBot.build(:blog, title: " " )}
      it { is_expected.to be_invalid }
    end

    describe "title blank" do
      let(:blog){FactoryBot.build(:blog, content: " " )}
    it { is_expected.to be_invalid }
    end
  end

end
