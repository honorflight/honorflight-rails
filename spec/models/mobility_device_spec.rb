require 'rails_helper'

RSpec.describe MobilityDevice, type: :model do
  it { should have_many(:people)}
end
