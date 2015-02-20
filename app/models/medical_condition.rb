class MedicalCondition < ActiveRecord::Base
  belongs_to :person
  belongs_to :medical_condition_type
  belongs_to :medical_condition_name
end
