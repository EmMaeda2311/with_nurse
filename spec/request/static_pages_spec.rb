require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  
  
  
  describe 'root' do
    it "response successfully" do
      get root_path
      expect(response).to be_successful
    end
    it 'returns a 200 response' do
      get root_path
      expect(response).to have_http_status (200)
    end
    
  end

  describe 'home' do
    it "response successfully" do
      get static_pages_home_path
      expect(response).to be_successful
    end
    it 'returns a 200 response' do
      get static_pages_home_path
      expect(response).to have_http_status (200)
    end
    
  end
  
  describe 'about' do
    it "response successfully" do
      get static_pages_about_path
      expect(response).to be_successful
    end
    it 'returns a 200 response' do
      get static_pages_about_path
      expect(response).to have_http_status (200)
    end
    
  end
  
  describe 'help' do
    it "response successfully" do
      get static_pages_help_path
      expect(response).to be_successful
    end
    it 'returns a 200 response' do
      get static_pages_help_path
      expect(response).to have_http_status (200)
    end
    
  end
end