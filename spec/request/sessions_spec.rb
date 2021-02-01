require 'rails_helper'

RSpec.describe "Sessions" ,type: :request do
  let(:tester) { FactoryBot.create(:tester)}
  let(:tester_params) { attributes_for(:tester) }
  let(:guest_user_params) { attributes_for(:user, name: "") }
  let(:another_teser){FactoryBot.create(:another_teser)}
  
  describe "get new page" do  
    it "sign_in returns a 200 request" do
      get new_user_session_path
      expect(response).to have_http_status (200)
    end
  end
  
  describe "as an authenticated user" do
    before do
      sign_in tester
    end
    
    # it "is signed_in" do
    #   expect(user_signed_in?).to be_truthy
    # end
    
    
    it "edit_page responds a 200" do
      get edit_user_registration_path
      expect(response).to have_http_status (200)
    end
    
    it "show_page responds a 200" do
      user_id = tester.id
      get "/users/#{user_id}"
      expect(response).to have_http_status (200)
    end
    
    
    
    it "log_out_test" do 
      sign_out tester
      get edit_user_registration_path
      expect(response).to have_http_status (302)
    end
  end
  
  
  describe "as a guest" do 
    it "edit_page responds a 302" do
      get edit_user_registration_path
      expect(response).to have_http_status (302)
    end
    
     it "show_page responds a 302" do
      user_id = tester.id
      get "/users/#{user_id}"
      # expect(response).to have_http_status (302)
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  
  describe "another_user not access mypage" do
    before do
      sign_in another_teser
    end
    
    
    #他のユーザーの編集ページにアクセスできないテスト→できちゃう
    # it "dont access tester edit page " do
    #   get edit_user_registration_path(tester)
    #   expect(response).to have_http_status (302)
    # end
    
  end
end