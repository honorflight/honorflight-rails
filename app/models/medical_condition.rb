class MedicalCondition < ActiveRecord::Base
  attr_encrypted :diagnosed_at, :last_occurrence, :comment, key: :encryption_key
  # attr_encrypted :diagnosed_last, :description, key: 'future key alg', marshal: true, marshaler: Marshel::Date

  belongs_to :person
  belongs_to :medical_condition_type
  belongs_to :medical_condition_name

  def as_json(options={})
    super(:only => [:id, :person_id, :medical_condition_name_id, :medical_condition_type_id]).merge(diagnosed_at: self.diagnosed_at, last_occurrence: self.last_occurrence, comment: self.comment)
  end
end
