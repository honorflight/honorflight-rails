class MedicalConditionType < ActiveRecord::Base
  attr_encrypted :name, key: :encryption_key

	has_many :medical_condition_names
	has_many :medical_conditions

  def as_json(options={})
    super(:only => [:id]).merge('name' => self.name)
  end
end
