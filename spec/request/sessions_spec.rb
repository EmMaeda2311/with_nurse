require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  it "sign_in returns a 200 request" do
    get sign_in_path
    expect(response).to have_http_status (200)
  end
end