require 'rails_helper'

RSpec.describe TravelCompanion, type: :model do
  it {should belong_to(:veteran)}
end
