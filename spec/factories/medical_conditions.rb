FactoryGirl.define do
  factory :medical_condition do
    diagnosed_at "2015-02-20"
    last_occurrence "2015-02-20"
    comment "MyText"
    person nil
    medical_condition_type nil
    medical_condition_name nil
  end

end
