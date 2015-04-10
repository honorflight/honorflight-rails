class ChangeFlightIdToDayOfFlightIdOnFlightDetails < ActiveRecord::Migration
  def change
    remove_foreign_key :flight_details, :flights
    rename_column :flight_details, :flight_id, :day_of_flight_id
    # add_index :flight_details, :day_of_flight_id
    add_foreign_key :flight_details, :day_of_flights
  end
end
