require 'rails_helper'

RSpec.describe MedicalConditionType, type: :model do
  it { should have_many(:medical_condition_names) }
  it { should have_many(:medical_conditions) }
end
