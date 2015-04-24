class SmsController < ActionController::Base
  def receiver
    # receive a message from twilio and do something with it
    # first we have to see what twilio sends
    render nothing: true
  end
end