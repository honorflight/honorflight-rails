class RenameFlights < ActiveRecord::Migration
  def change
    rename_table :flights, :day_of_flights
  end
end
