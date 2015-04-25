class SmsController < ActionController::Base
  def receiver
    # Make it more ruby like
    sms_hash = Hash[params.map{ |k, v| [k.underscore.to_sym, v] }]

    # If DayOfFlight is notifiable and the person sending message is on flight
    # then go ahead and send stuff out
    # Else build a invalid responder
    if flight = DayOfFlight.current
      if flight.phone_on_flight(sms_hash[:from])
        # Legit... GO GO GO
        # Blecht
        # flight = DayOfFlight.current;sms_message = SmsMessage.last; flight.build_response_from_sms(sms_message)
        #
        # Persist the incoming message, 
        if sms_message = flight.sms_messages.create(sms_hash)
          flight.build_response_from_sms(sms_message)
          twiml = build_twiml_response "Message was received and processed. Thank you!"
        else
          twiml = build_twiml_response
        end
      else
        twiml = build_twiml_response
      end
    else
      # Return invalid response to flying today
      twiml = build_twiml_response
    end

    render text: twiml.text
  end

  private
  def build_twiml_response(message = "This number is not available for texting right now. Please try later.")
    Twilio::TwiML::Response.new do |r|
      r.Message message
    end
  end
end