class AddFlightToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :flight, index: true
    add_foreign_key :people, :flights
  end
end
