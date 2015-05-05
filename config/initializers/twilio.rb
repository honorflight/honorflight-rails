unless Rails.env == "test" || Rails.env == "development"
  Twilio.configure do |config|
    config.account_sid = ENV.fetch('TWILIO_ACCOUNT_SID') || "ABCDEF"
    config.auth_token = ENV.fetch('TWILIO_AUTH_TOKEN') || "ABCDEF"
  end
else
  Twilio.configure do |config|
    config.account_sid = "SomeSid"
    config.auth_token = "SomeAuthToken"
  end
end