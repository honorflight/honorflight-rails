unless Rails.env == "test"
  Twilio.configure do |config|
    config.account_sid = ENV.fetch('TWILIO_ACCOUNT_SID')
    config.auth_token = ENV.fetch('TWILIO_AUTH_TOKEN')
  end
else
  Twilio.configure do |config|
    config.account_sid = "SomeSid"
    config.auth_token = "SomeAuthToken"
  end
end