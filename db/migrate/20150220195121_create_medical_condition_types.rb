class CreateMedicalConditionTypes < ActiveRecord::Migration
  def change
    create_table :medical_condition_types do |t|
      t.string :encrypted_name
      t.text :description

      t.timestamps null: false
    end
  end
end
