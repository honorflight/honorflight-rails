class RenameMedicalConditionDescription < ActiveRecord::Migration
  def change 
  	rename_column(:medical_conditions, :encrypted_description, :encrypted_comment)
  	rename_column(:medical_conditions, :encrypted_diagnosed_last, :encrypted_last_occurrence)
  end
end
