require 'rails_helper'

RSpec.describe FlightAttachment, type: :model do
  it { should belong_to(:day_of_flight)}
end
