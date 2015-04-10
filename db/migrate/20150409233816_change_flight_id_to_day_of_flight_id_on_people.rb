class ChangeFlightIdToDayOfFlightIdOnPeople < ActiveRecord::Migration
  def change
    remove_foreign_key :people, :flights
    rename_column :people, :flight_id, :day_of_flight_id
    # add_index :people, :day_of_flight_id
    add_foreign_key :people, :day_of_flights
  end
end
