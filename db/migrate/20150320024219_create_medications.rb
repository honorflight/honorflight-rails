class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :medication
      t.string :dose
      t.string :frequency
      t.string :route
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :medications, :people
  end
end
