require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  it { should belong_to(:person) }

  it { should belong_to(:day_of_flight) }

  it { should validate_presence_of(:day_of_flight) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:person)}

  describe "on incoming text" do
    it "should set a person if on fligh" do
      f = FactoryGirl.create(:volunteer)
      d = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
      expect(d).to receive(:phone_on_flight).and_return(f)
      expect(d.sms_messages.create(FactoryGirl.attributes_for(:sms_message, body: "Debugger", from: f.text_phone))).to eql(SmsMessage.last)
    end
  end
end
