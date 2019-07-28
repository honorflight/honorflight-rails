class MedicalConditionType < ActiveRecord::Base
  attr_encrypted :name, key: ENV['ENCRYPTION_KEY_MEDICALCONDITIONNAME'], mode: :attr_encrypted, algorithm: 'aes-256-cbc'


	has_many :medical_condition_names
	has_many :medical_conditions

  def as_json(options={})
    super(:only => [:id]).merge('name' => self.name)
  end
end
