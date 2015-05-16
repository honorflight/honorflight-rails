require 'rails_helper'

RSpec.describe Veteran, type: :model do
  it { should have_many(:medical_conditions) }
  it { should have_many(:medications)}
  it { should have_many(:medical_allergies)}
  it { should have_many(:travel_companions)}
end