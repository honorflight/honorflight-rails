require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  it { should validate_presence_of(:first_name)}
  it { should have_many(:day_of_flights_volunteers)}
  it { should have_many(:day_of_flights).through(:day_of_flights_volunteers)}
  it { should have_many(:roles).through(:volunteers_roles)}
  it { should have_many(:volunteers_roles)}
end
