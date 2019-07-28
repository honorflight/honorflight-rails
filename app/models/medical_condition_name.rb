class MedicalConditionName < ActiveRecord::Base
  attr_encrypted :name, key: ENV['ENCRYPTION_KEY_MEDICALCONDITIONNAME'], mode: :attr_encrypted, algorithm: 'aes-256-cbc'

  belongs_to :medical_condition_type

  has_many :medical_condition_names
  has_many :medical_conditions

  def as_json(options={})
    super(:only => [:id, :medical_condition_type_id]).merge('name' => self.name)
  end
end
