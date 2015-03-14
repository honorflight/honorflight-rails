require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should have_many(:service_histories) }
  it { should have_one(:address) }
  it { should validate_presence_of(:birth_date) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should belong_to(:war) }
  it { should have_many(:medical_conditions) }
  it { should have_many(:service_awards) }
  it { should belong_to(:shirt_size) }
  it { should belong_to(:flight)}
  it { should have_one(:emergency_contact)}
  it { should have_one(:alternate_contact)}
  it { should have_many(:contacts)}
  it { should have_one(:physician_contact)}


  describe "#uuid" do
    subject(:person) { FactoryGirl.create(:person) }
    it "assigns a uuid" do
      expect(person.uuid.length).to be_between(20, 200)
    end
  end
end
