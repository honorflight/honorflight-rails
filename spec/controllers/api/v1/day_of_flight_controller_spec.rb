require 'rails_helper'

RSpec.describe API::V1::DayOfFlightController, type: :controller do
  describe "authenticated" do
    before do
      @admin_user = FactoryGirl.create(:admin_user)
      request.accept = 'application/json'
      request.headers['CONTENT_TYPE'] = 'application/json'
      request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
      @flight = FactoryGirl.create(:day_of_flight, flies_on: Date.tomorrow)
      @guardian = FactoryGirl.create(:guardian)
      @veteran = FactoryGirl.create(:veteran, day_of_flight_id: @flight.id)
      @veteran.guardian = @guardian
      @veteran.save
      FactoryGirl.create(:volunteer, day_of_flight_id: @flight.id)
    end

    # GET /api/v1/day_of_flight/people
    it 'returns the people on a flight' do
      get :people

      expect(response).to be_success
      json = JSON.parse(response.body)

      expect(json["id"]).to be_a(Integer)
      expect(json["id"]).to eql(@flight.id)
      expect(json["guardians"].count).to eql(1)
      expect(json["veterans"].count).to eql(1)
      expect(json["volunteers"].count).to eql(1)

      # expect(json["veterans"]).to be([])
      # expect(Person.last.veteran?).to eql(true)
    end
  end
end