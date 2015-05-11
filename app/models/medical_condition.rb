class MedicalCondition < ActiveRecord::Base
  attr_encrypted :diagnosed_at,  key: ENV["ENCRYPTION_KEY_MEDICALCONDITION"], marshal: true, marshaler: Marshel::Date
  attr_encrypted :last_occurrence, key: ENV["ENCRYPTION_KEY_MEDICALCONDITION"], marshal: true, marshaler: Marshel::Date
  attr_encrypted :comment, key: ENV["ENCRYPTION_KEY_MEDICALCONDITION"]
  # attr_encrypted :diagnosed_last, :description, key: 'future key alg', marshal: true, marshaler: Marshel::Date

  belongs_to :person
  belongs_to :medical_condition_type
  belongs_to :medical_condition_name

  before_validation :set_last_occurrence
  def set_last_occurrence
    if self.last_occurrence.blank?
      self.last_occurrence=Date.today
    end
  end

  def last_occurrence=(d)
    self[:encrypted_last_occurrence] = MedicalCondition.encrypt_last_occurrence(d)
  end

  def as_json(options={})
    super(:only => [:id, :person_id, :medical_condition_name_id, :medical_condition_type_id]).merge(diagnosed_at: self.diagnosed_at, last_occurrence: self.last_occurrence, comment: self.comment)
  end
end
