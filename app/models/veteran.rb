class Veteran < Person
  has_one :mobility_device
  has_many :medical_conditions, foreign_key: "person_id"
  has_many :medications, foreign_key: "person_id"
  has_many :medical_allergies, foreign_key: "person_id"

  belongs_to :mobility_device
  has_one :guardian, class_name: "guardian"

  accepts_nested_attributes_for :medical_conditions, :allow_destroy => true
  accepts_nested_attributes_for :medications
  accepts_nested_attributes_for :medical_allergies
end
