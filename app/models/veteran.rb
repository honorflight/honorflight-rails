class Veteran < Person
  has_one :mobility_device
  has_many :medical_conditions, foreign_key: "person_id"
  has_many :medications, foreign_key: "person_id"
  has_many :medical_allergies, foreign_key: "person_id"
  has_many :travel_companions

  belongs_to :mobility_device
  belongs_to :guardian

  accepts_nested_attributes_for :medical_conditions, allow_destroy: true
  accepts_nested_attributes_for :medications
  accepts_nested_attributes_for :medical_allergies, allow_destroy: true
  accepts_nested_attributes_for :travel_companions, allow_destroy: true
end
