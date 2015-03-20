class AddMobilityDeviceToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :mobility_device, index: true
    add_foreign_key :people, :mobility_devices
  end
end
