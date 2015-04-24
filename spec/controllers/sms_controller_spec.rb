require 'rails_helper'

RSpec.describe SmsController, type: :controller do
  # Have Twilio configured to send 2 times
  it 'post receiver' do
    post :receiver, message: {field: "1", person: "2"}
    expect(response).to be_success
  end
end