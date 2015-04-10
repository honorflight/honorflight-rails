class CreateFlightResponsibilities < ActiveRecord::Migration
  def change
    create_table :flight_responsibilities do |t|
      t.string :name
      t.text :description
      t.references :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :flight_responsibilities, :roles
  end
end
