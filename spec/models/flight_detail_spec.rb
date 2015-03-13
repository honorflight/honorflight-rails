require 'rails_helper'

RSpec.describe FlightDetail, type: :model do
  it { should validate_presence_of(:destination)}
  it { should validate_presence_of(:departs_from)}
  it { should validate_presence_of(:arrives_at)}
  it { should validate_presence_of(:departs_at)}
  it { should validate_presence_of(:flight_number)}
  it { should validate_presence_of(:airline)}
  it { should validate_presence_of(:departure_gate)}
  it { should validate_presence_of(:arrival_gate)}
  it { should belong_to(:flight)}
  it { should belong_to(:airline)}

end
