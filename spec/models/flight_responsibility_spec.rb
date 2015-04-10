require 'rails_helper'

RSpec.describe FlightResponsibility, type: :model do
  it { should belong_to(:role) }
  it { should have_many(:day_of_flights_volunteers)}
end
