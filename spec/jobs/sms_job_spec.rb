require 'rails_helper'
require 'twilio_helper'

# describe "some test that raises error" do
#   let(:bad_statement) { something_that_raises_an_error }
#   subject { -> { bad_statement } }
#   it { should raise_error }
# end

RSpec.describe SmsJob do
  describe "No options" do
    let(:bad_options) { SmsJob.new.perform() }
    subject { -> { bad_options } }
    it { should raise_error }
  end

  describe "No phone number" do
    let(:bad_options) { SmsJob.new.perform(message: "Hello World") }
    subject { -> { bad_options } }
    it { should raise_error }
  end

  describe "No message" do
    let(:bad_options) { SmsJob.new.perform(number: "+13148675309") }
    subject { -> { bad_options } }
    it { should raise_error }
  end

  # TODO: Figure this spec out eventually
  # describe "Valid sms should create message" do
  #   it "should call twilio api" do
  #     expect(Twilio::REST::Client).to receive(:new)
  #     expect_any_instance_of(Twilio::REST::Client).to receive_message_chain(:messages, :create) { true }
  #     expect(SmsJob.new.perform(number: "+13148675309", message: "Hello World")).to eql("Hell Yeah")
  #   end
  # end
end
