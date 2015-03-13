class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.date :flies_on
      t.references :war, index: true
      t.text :special_instruction

      t.timestamps null: false
    end
    add_foreign_key :flights, :wars
    add_foreign_key :flight_details, :flights
  end
end
