class CreateMedicalConditions < ActiveRecord::Migration
  def change
    create_table :medical_conditions do |t|
      t.string :encrypted_diagnosed_at
      t.string :encrypted_diagnosed_last
      t.text :encrypted_description
      t.references :person, index: true
      t.references :medical_condition_type, index: true
      t.references :medical_condition_name, index: true

      t.timestamps null: false
    end
    add_foreign_key :medical_conditions, :people
    add_foreign_key :medical_conditions, :medical_condition_types
    add_foreign_key :medical_conditions, :medical_condition_names
  end
end
