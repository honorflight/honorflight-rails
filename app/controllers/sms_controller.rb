class SmsController < ActionController::Base
  def receiver
    # receive a message from twilio and do something with it
    # first we have to see what twilio sends

    # {
    #   "ToCountry"=>"US", 
    #   "ToState"=>"MO", 
    #   "SmsMessageSid"=>"SM80a29fe0e5fae35f1699ce7cab29159d", 
    #   "NumMedia"=>"0", 
    #   "ToCity"=>"", 
    #   "FromZip"=>"63124", 
    #   "SmsSid"=>"SM80a29fe0e5fae35f1699ce7cab29159d", 
    #   "FromState"=>"MO", 
    #   "SmsStatus"=>"received", 
    #   "FromCity"=>"LADUE", 
    #   "Body"=>"Tester", 
    #   "FromCountry"=>"US", 
    #   "To"=>"+13147363417", 
    #   "ToZip"=>"", 
    #   "MessageSid"=>"SM80a29fe0e5fae35f1699ce7cab29159d", 
    #   "AccountSid"=>"ACc8d1705a76e993fd61b48285ced2198e", 
    #   "From"=>"+13147038829", "ApiVersion"=>"2010-04-01"
    # }

    # Make it more ruby like
    sms_hash = Hash[params.map{ |k, v| [k.underscore.to_sym, v] }]
    # {:to_country=>"US",
    #  :to_state=>"MO",
    #  :sms_message_sid=>"SM80a29fe0e5fae35f1699ce7cab29159d",
    #  :num_media=>"0",
    #  :to_city=>"",
    #  :from_zip=>"63124",
    #  :sms_sid=>"SM80a29fe0e5fae35f1699ce7cab29159d",
    #  :from_state=>"MO",
    #  :sms_status=>"received",
    #  :from_city=>"LADUE",
    #  :body=>"Tester",
    #  :from_country=>"US",
    #  :to=>"+13147363417",
    #  :to_zip=>"",
    #  :message_sid=>"SM80a29fe0e5fae35f1699ce7cab29159d",
    #  :account_sid=>"ACc8d1705a76e993fd61b48285ced2198e",
    #  :from=>"+13147038829",
    #  :api_version=>"2010-04-01"}

    # twiml = Twilio::TwiML::Response.new do |r|
    #     r.Message do |message|
    #     message.Body "Body"
    #     message.MediaUrl "https://demo.twilio.com/owl.png"
    #     message.MediaUrl "https://demo.twilio.com/logo.png"
    #     end
    # end
    # twiml.text

    # If DayOfFlight is notifiable and the person sending message is on flight
    # then go ahead and send stuff out
    # Else build a invalid responder
    if flight = DayOfFlight.find_by(flies_on: [Date.tomorrow, Date.today, Date.yesterday])

    else
      # Return invalid response to flying today
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message do |message|
          message.Body = "This number is not available for texting right now. Please try later."
        end
      end
    end

    render text: twiml.text
  end
end