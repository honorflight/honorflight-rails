class CreateFlightAttachments < ActiveRecord::Migration
  def change
    create_table :flight_attachments do |t|
      t.references :day_of_flight, index: true
      t.string :name
      t.string :comments

      t.timestamps null: false
    end
    add_foreign_key :flight_attachments, :day_of_flights
  end
end
