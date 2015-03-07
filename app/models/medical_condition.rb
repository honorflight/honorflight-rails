class MedicalCondition < ActiveRecord::Base
  attr_encrypted :diagnosed_at, :key => 'future key alg'
  attr_encrypted :diagnosed_last, :description, key: 'future key alg', marshal: true, marshaler: Marshel::Date

  belongs_to :person
  belongs_to :medical_condition_type
  belongs_to :medical_condition_name
end
