require 'rails_helper'

RSpec.describe DayOfFlight, type: :model do
  it { should belong_to(:war)}
  it { should validate_presence_of(:flies_on)}
  it { should have_many(:people)}
  it { should have_many(:veterans)}
  # it { should have_many(:guardians).through(:veterans)}
  it { should have_many(:day_of_flights_volunteers)}
  it { should have_many(:volunteers).through(:day_of_flights_volunteers)}
  it { should have_many(:flight_attachments)}

  it { should accept_nested_attributes_for(:flight_attachments)}


  describe "#flies_on" do
    it "should print as date" do
      f = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
      expect(f.to_s).to eql(Date.today.to_s(:long))
    end
  end

  describe "#current" do
    it "should return the current flight" do
      f = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
      expect(DayOfFlight.current).to eql(f)
    end

    it "should not return any flight" do
      FactoryGirl.create(:day_of_flight)
      expect(DayOfFlight.current).to equal(nil)
    end
  end

  describe "#is_notifiable?" do
    it "should be notifiable on day before, of and day after" do
      days = [Date.today, Date.today - 1.day, Date.today + 1.day]
      days.each do |day|
        f = FactoryGirl.create(:day_of_flight, flies_on: day)
        expect(f.is_notifiable?).to eql(true)
      end
    end

    it "should not be notifiable 2 days after or before flight" do
      days = [Date.today - 2.days, Date.today + 2.days]
      days.each do |day|
        f = FactoryGirl.create(:day_of_flight, flies_on: day)
        expect(f.is_notifiable?).to eql(false)
      end
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

  describe "#guardians"

  describe "#valid_number" do
    before(:each) do
      @veterans = FactoryGirl.create_list(:veteran, 10)

      @guardians = FactoryGirl.create_list(:guardian, 10)

      @guardian_first = @guardians.first
      @guardian_first.cell_phone = "314-555-1212"
      @guardian_first.save!

      @volunteers = FactoryGirl.create_list(:volunteer, 10)

      @flight = FactoryGirl.create(:day_of_flight, flies_on: Date.today)

      temp_guardians = @guardians.clone
      @veterans.each do |vet|
        vet.guardian = temp_guardians.pop
        @flight.veterans << vet
      end

      @role = FactoryGirl.create(:role, short_code: "Rob")
      flight_responsibility = FactoryGirl.create(:flight_responsibility, role: @role)



      @flight.volunteers = @volunteers.sample(3)

      @flight_volunteer_first = @flight.volunteers.first
      @flight_volunteer_first.roles << @role
      @flight_volunteer_first.cell_phone = "413-555-1212"
      @flight_volunteer_first.save
      @flight.save

      #@flight.day_of_flights_volunteers << 
      DayOfFlightsVolunteer.where(person_id: @flight_volunteer_first.id, day_of_flight_id: @flight.id).first.update_attributes(flight_responsibility_id: flight_responsibility.id)

      expect(@flight.people_count).to eql(23)
      @guardian_sms_message = FactoryGirl.create(
        :sms_message, 
        from: @guardian_first.text_phone,
        day_of_flight_id: @flight.id)
      @flight_volunteer_sms_message = FactoryGirl.create(
        :sms_message,
         from: @flight_volunteer_first.text_phone,
         day_of_flight_id: @flight.id)

      # binding.pry

    end

    it "flight volunteer should be role short code Rob" do
      expect(@flight.role_short_code(@flight_volunteer_first.id)).to eql("Rob")
    end

    it "should have 10 guardians" do
      expect(@guardians.count).to eql(10)
      expect(@guardians.first.class).to be(Guardian)
    end

    it "should have 10 day of flight guardians" do
      expect(@flight.guardians.count).to eql(10)
    end

    it "should have 3 volunteers" do
      expect(@flight.volunteers.count).to eql(3)
    end

    describe "should restrict to a number on flight" do
      it "guardian should be on flight" do
        expect(@flight.phone_on_flight(@guardian_first.text_phone)).to eql(@guardian_first)
      end

      it "volunteer should be on flight" do
        expect(@flight.phone_on_flight(@flight_volunteer_first.text_phone)).to eql(@flight_volunteer_first)
      end

      # it "guardian should be on flight" do
      #   expect(@flight.phone_on_flight(@guardians.first.phone)).to eql(@guardians.first)
      # end

      it "+13148675309 should not be on flight" do
        expect(@flight.phone_on_flight("+13148675309")).to be(nil)
      end
    end

    describe "#volunteers_phones" do
      it "should return 3 phones" do
        expect(@flight.volunteers_phones.count).to eql(3)
      end
    end

    describe "#volunteers_guardians_phones" do
      it "should return 13 combined phones" do
        resp = @flight.build_response_from_sms(@flight_volunteer_sms_message)
        expect(resp[:numbers].count).to eql(13)
        expect(resp[:message].class).to eql(String)
        expect(resp[:message]).to eql("(#{@role.short_code}) #{@flight_volunteer_first.text_name}: #{@flight_volunteer_sms_message.body}")
        # (G)F. Lastname, (V)F.Lastname): {in_message}
      end
    end

    describe "build_response_from_sms" do
      it "guardian should respond to flight volunteers" do
        message = "Hello World!"
        resp = @flight.build_response_from_sms(@guardian_sms_message)
        expect(resp[:numbers].count).to eql(3)
        expect(resp[:message].class).to eql(String)
        expect(resp[:message]).to eql("(Guard) #{@guardian_first.text_name}:(#{@guardian_first.text_phone}), (Vet) #{@guardian_first.veteran.text_name}: #{@guardian_sms_message.body}")
      end

      it "volunteer should respond to flight guardians and volunteers"
    end
  end
end


