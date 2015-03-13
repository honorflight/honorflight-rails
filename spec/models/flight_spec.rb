require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { should belong_to(:war)}
  it { should validate_presence_of(:flies_on)}
  it { should have_many(:people)}
end
