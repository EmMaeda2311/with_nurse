module LoginHelper

  #ログインする(feature)
  def valid_login(user)
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password

    within '.actions' do
      click_on "ログイン"
    end
  end
  
    #ログインする(request)
  def login_as(tester)
    post user_session_path, params: { session: { 
                                                emial: tester.email,
                                                password: tester.password,
                                                remember_me: '1'} }
  end

end

RSpec.configure do |config|
  config.include LoginHelper
end