class CreateFlightDetails < ActiveRecord::Migration
  def change
    create_table :flight_details do |t|
      t.string :destination
      t.string :departs_from
      t.datetime :arrives_at
      t.datetime :departs_at
      t.string :flight_number
      t.references :airline, index: true
      t.references :flight, index: true
      t.string :departure_gate
      t.string :arrival_gate

      t.timestamps null: false
    end
    add_foreign_key :flight_details, :airlines
  
  end
end
