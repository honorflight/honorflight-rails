class CreateMedicalConditionNames < ActiveRecord::Migration
  def change
    create_table :medical_condition_names do |t|
      t.string :encrypted_name
      t.text :description
      t.references :medical_condition_type, index: true

      t.timestamps null: false
    end
    add_foreign_key :medical_condition_names, :medical_condition_types
  end
end
