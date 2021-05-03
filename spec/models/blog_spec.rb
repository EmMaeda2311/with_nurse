require 'rails_helper'

RSpec.describe Blog, type: :model do
  subject { blog }
  let(:blog) { FactoryBot.build(:blog) }

  describe 'valid blog' do
    it { is_expected.to be_valid }
  end

  describe 'invalid blog' do
    describe 'user_id be present' do
      let(:blog) { FactoryBot.build(:blog, user_id: nil) }
      it { is_expected.to be_invalid }
    end

    describe 'title blank' do
      let(:blog) { FactoryBot.build(:blog, title: ' ') }
      it { is_expected.to be_invalid }
    end

    describe 'title blank' do
      let(:blog) { FactoryBot.build(:blog, content: ' ') }
      it { is_expected.to be_invalid }
    end
  end

  describe '新しい順に並んでいるか' do
    let(:blog) { FactoryBot.create(:blog) }
    let(:blog1) { FactoryBot.create(:blog1) }
    let(:blog2) { FactoryBot.create(:blog2) }
    let(:blog3) { FactoryBot.create(:blog3) }

    it '新しい順に並んでいる' do
      expect(blog3).to eq Blog.first
    end
  end
end
