require 'rails_helper'

RSpec.describe MedicalConditionName, type: :model do
  it { should have_many(:medical_conditions) }
  it { should belong_to(:medical_condition_type) }
end
