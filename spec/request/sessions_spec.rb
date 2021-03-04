require 'rails_helper'

RSpec.describe "Sessions" ,type: :request do
  let(:tester) { FactoryBot.create(:tester)}
  let(:tester_params) { attributes_for(:tester) }
  let(:guest_user_params) { attributes_for(:user, name: "") }
  let(:another_tester){FactoryBot.create(:another_tester)}
  

  describe "サインアップできる" do
    it "new_signup_page" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end

    it "signup" do
      expect{ post user_registration_path, params:{ blog: {username: "masa", email: "tester@example.com", password: "foobar"}}}.to change{ User.count }.by(0)
    end
      
  end


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
    
    
    it "can`t access another_tester_page" do
      get "/users/#{another_tester.id}"
      expect(response).to redirect_to( root_url )
    end
    
    it "is not exist user" do
      get "/users/100000"
      expect(response).to redirect_to( root_url )
    end
    
    it "log_out_test" do 
      sign_out tester
      get edit_user_registration_path
      expect(response).to have_http_status (302)
    end

  end
  
  # describe "rememberable test" do
    
  #   it "remember_created_at is nil" do
  #     sign_in tester
  #     expect(tester.remember_created_at).to eq nil
  #     # sign_out tester
  #     # expect(tester.rememberable_value).to eq nil
  #     # expect(another_tester.rememberable_value).to eq nil
  #   end
    
  #   it "login with remembering" do
  #     sign_in tester
  #     tester.remember_created_at = DateTime.now
  #     expect(tester.rememberable_value).not_to eq nil
  #   end
  # end
  
  
  describe "as a guest" do 
    it "edit_page responds a 302" do
      get edit_user_registration_path
      expect(response).to have_http_status (302)
    end
    
     it "show_page responds a 302" do
      user_id = tester.id
      get "/users/#{user_id}"
      expect(response).to have_http_status (302)
      # expect(response).to redirect_to new_user_session_path
    end

    it "delete responds a 302" do
      user_id = tester.id
      delete user_registration_path
      expect(response).to have_http_status (302)
    end
    
    it "unless loginn user redirect_to login_page" do
      get edit_user_registration_path
      expect(response).to redirect_to new_user_session_path
    end
    
  end
  
  
  # describe "show form root page redirect test" do
    
    
    
  #   #他のユーザーの編集ページにアクセスできないテスト→できちゃう
  #   # it "dont access tester edit page " do
  #   #   get edit_user_registration_path(tester)
  #   #   expect(response).to have_http_status (302)
  #   # end
    
  # end
  
end