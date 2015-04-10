require 'rails_helper'

RSpec.describe DayOfFlightsVolunteer, type: :model do
  it { should belong_to(:volunteer)}
  it { should belong_to(:day_of_flight)}
  it { should belong_to(:flight_responsibility)}
end
