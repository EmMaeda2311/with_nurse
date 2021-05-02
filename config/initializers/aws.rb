creds = Aws::Credentials.new(
  ENV['AWS_ACCESS_KEY'],
  ENV['AWS_SECRET_KEY']
)

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: 'ap-northeast-1'
)
# ActionMailer::Base.add_delivery_method :ses,
#                                        AWS::SES::Base,
#                                        access_key_id: ENV['AWS_ACCESS_KEY'],
#                                        secret_access_key: ENV['AWS_SECRET_KEY'],
#                                        server: ENV['AWS_EMAIL_SERVER']