class CreateMedicationRoutes < ActiveRecord::Migration
  def change
    create_table :medication_routes do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
