require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  it { should validate_presence_of(:first_name)}
  it { should have_many(:day_of_flights_volunteers)}
  it { should have_many(:day_of_flights).through(:day_of_flights_volunteers)}
  it { should have_many(:roles).through(:volunteers_roles)}
  it { should have_many(:volunteers_roles)}


  describe "text_phone number" do
    it "should have a text cleansed number" do
      FactoryGirl.create(:volunteer, :cell_phone => "314-555-1212")

      expect(Volunteer.first.text_phone).to eql("13145551212")
    end
  end
end
