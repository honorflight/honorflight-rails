class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
