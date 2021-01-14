require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'With Nurse ナース専用のソーシャルメディア' }
  
  
  describe 'root' do
    it 'returns a 200 response' do
      get root_path
      expect(response).to have_http_status (200)
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
    
  end

  describe 'home' do
    it 'returns a 200 response' do
      get static_pages_home_path
      expect(response).to have_http_status (200)
    end
    
  end
  
  describe 'about' do
    it 'returns a 200 response' do
      get static_pages_about_path
      expect(response).to have_http_status (200)
    end
    
  end
  
  describe 'help' do
    it 'returns a 200 response' do
      get static_pages_help_path
      expect(response).to have_http_status (200)
    end
    
  end
end