require 'rails_helper'

RSpec.describe MedicalCondition, type: :model do
  it { should belong_to(:person) }
  it { should belong_to(:medical_condition_type) }
  it { should belong_to(:medical_condition_name) }
end
