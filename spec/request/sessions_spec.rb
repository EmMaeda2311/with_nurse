require 'rails_helper'

RSpec.describe "Sessions" ,type: :request do
  let(:tester) { FactoryBot.create(:tester)}
  let(:tester_params) { attributes_for(:tester) }
  let(:guest_user_params) { attributes_for(:user, name: "") }  
  
  describe "get new page" do  
    it "sign_in returns a 200 request" do
      get sign_in_path
      expect(response).to have_http_status (200)
    end
  end
  
  describe "as an authenticated user" do
    before do
      sign_in tester
    end

    it "edit_page responds a 200" do
      get edit_user_registration_path
      expect(response).to have_http_status (200)
    end
    
    it "show_page responds a 200" do
      user_id = tester.id
      get "/users/#{user_id}"
      expect(response).to have_http_status (200)
    end
    
  end
  
  
  # describe "as a guest" do 
  #   it "redirects to the login page" do
  #     get users_show_path(tester)
  #     expect(response).to redirect_to sign_in_path
  #   end
  # end
end