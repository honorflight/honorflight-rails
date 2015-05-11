require 'rails_helper'

RSpec.describe MedicalCondition, type: :model do
  it { should belong_to(:person) }
  it { should belong_to(:medical_condition_type) }
  it { should belong_to(:medical_condition_name) }

  it "should persist last_occurrence" do
    x = FactoryGirl.create(:medical_condition, last_occurrence: Date.today)
    expect(x.last_occurrence).to eql(Date.today)
  end
end
