class MedicalConditionType < ActiveRecord::Base
	has_many :medical_condition_names
	has_many :medical_conditions
end
