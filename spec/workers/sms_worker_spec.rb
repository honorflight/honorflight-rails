require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SmsWorker do

  it "should schedule a job" do
    expect {
      SmsWorker.perform_async({message: "Hello World", number: "+13145551212"})
    }.to change(SmsWorker.jobs, :size).by(1)
  end

  # TODO
  # http://www.mutuallyhuman.com/blog/2012/04/03/testing-sms-interactions-in-ruby-on-rails/
  # it "should perform" do
  #   twilio_client = double('twilio_client')
  #   Twilio::REST::Client.stub(:new).and_return twilio_client

  #   expect(SmsWorker.perform).to eql true
  #   # twilio_client.stub_chain(:messages, :create)
  # end
end
