class SmsJob
  include SuckerPunch::Job

  def perform(options) # Should be a sms-able number and a message
    raise "Please pass a phone number" if options[:number].blank?
    raise "Please pass a message" if options[:message].blank?

    @client ||= Twilio::REST::Client.new
    @client.messages.create(
      from: ENV.fetch("TWILIO_SMS_NUMBER"),
      to: options[:number],
      body: options[:message]
    )
  end
end