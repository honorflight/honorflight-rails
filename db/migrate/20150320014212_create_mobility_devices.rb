class CreateMobilityDevices < ActiveRecord::Migration
  def change
    create_table :mobility_devices do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
