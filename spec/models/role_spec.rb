require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_many(:volunteers).through(:volunteers_roles)}
  it { should have_many(:volunteers_roles)}
  it { should have_many(:flight_responsibilities) }
  it { should validate_length_of(:short_code).is_at_most(6) }
end
