class CreateDayOfFlightsVolunteers < ActiveRecord::Migration
  def change
    create_table :day_of_flights_volunteers do |t|
      t.references :day_of_flight, index: true
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :day_of_flights_volunteers, :day_of_flights
    add_foreign_key :day_of_flights_volunteers, :people
  end
end
