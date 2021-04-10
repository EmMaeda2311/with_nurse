require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  let(:base_title) { 'Home | With Nurse ナース専用のソーシャルメディア' }

  describe 'root' do
    it 'returns a 200 response' do
      get root_path
      expect(response).to have_http_status(200)
      # expect(response.body).to have_title(/<title>#{base_title}<\/title>/i)
      expect(response.body).to match(%r{<title>#{base_title}</title>}i)
    end
  end

  describe 'about' do
    it 'returns a 200 response' do
      get about_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'help' do
    it 'returns a 200 response' do
      get help_path
      expect(response).to have_http_status(200)
    end
  end
end
