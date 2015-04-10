require 'rails_helper'

RSpec.describe DayOfFlight, type: :model do
  it { should belong_to(:war)}
  it { should validate_presence_of(:flies_on)}
  it { should have_many(:people)}

  describe "#flies_on" do
    it "should print as date" do
      f = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
      expect(f.to_s).to eql(Date.today.to_s(:aa))
    end
  end

  describe "Airline names" do
    it "should return airlint names comma separated" do
      airline1 = FactoryGirl.create(:airline, name: "Southwest")
      airline2 = FactoryGirl.create(:airline, name: "Delta")

      flight = FactoryGirl.create(:day_of_flight)
      flight.flight_details << FactoryGirl.create(:flight_detail, airline: airline1)
      flight.flight_details << FactoryGirl.create(:flight_detail, airline: airline2)

      expect(flight.flight_details.count).to eql(2)

      expect(flight.airline_names).to eql("Southwest, Delta")
    end
    it "should return airlint names comma separated" do
      airline1 = FactoryGirl.create(:airline, name: "Southwest")

      flight = FactoryGirl.create(:day_of_flight)
      flight.flight_details << FactoryGirl.create(:flight_detail, airline: airline1)
      flight.flight_details << FactoryGirl.create(:flight_detail, airline: airline1)

      expect(flight.flight_details.count).to eql(2)

      expect(flight.airline_names).to eql("Southwest")
    end
  end
end
