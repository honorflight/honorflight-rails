class CreateMedicalAllergies < ActiveRecord::Migration
  def change
    create_table :medical_allergies do |t|
      t.string :medical_allergy
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :medical_allergies, :people
  end
end
