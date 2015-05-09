class SmsWorker
  include Sidekiq::Worker

  def perform(options)
    number = options["number"]
    message = options["message"]   

    @client ||= Twilio::REST::Client.new
    @client.messages.create(
      from: ENV.fetch("TWILIO_SMS_NUMBER"),
      to: number,
      body: message
    )
  end
end