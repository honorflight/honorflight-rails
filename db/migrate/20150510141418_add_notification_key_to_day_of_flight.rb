class AddNotificationKeyToDayOfFlight < ActiveRecord::Migration
  def change
    add_column :day_of_flights, :notification_key, :string
  end
end
