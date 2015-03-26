class RemoveRouteFromMedication < ActiveRecord::Migration
  def change
    remove_column :medications, :route, :string
  end
end
