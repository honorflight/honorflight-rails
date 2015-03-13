require 'rails_helper'

RSpec.describe Airline, type: :model do
  it { should validate_presence_of(:name)}
  it { should have_many(:flight_details)}
end
