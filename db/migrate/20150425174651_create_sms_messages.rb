class CreateSmsMessages < ActiveRecord::Migration
  def change
    create_table :sms_messages do |t|
      t.string :to_country
      t.string :to_state
      t.string :sms_message_sid
      t.string :num_media
      t.string :to_city
      t.string :from_zip
      t.string :sms_sid
      t.string :from_state
      t.string :sms_status
      t.string :from_city
      t.text :body
      t.string :from_country
      t.string :to
      t.string :to_zip
      t.string :message_sid
      t.string :from
      t.string :api_version
      t.references :day_of_flight, index: true
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :sms_messages, :day_of_flights
    add_foreign_key :sms_messages, :people
  end
end
