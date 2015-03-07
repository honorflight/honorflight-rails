class MedicalConditionType < ActiveRecord::Base
  attr_encrypted :name, :key => 'future key alg'

	has_many :medical_condition_names
	has_many :medical_conditions
end
