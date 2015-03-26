class AddMedicationRouteToMedication < ActiveRecord::Migration
  def change
    add_reference :medications, :medication_route, index: true
    add_foreign_key :medications, :medication_routes
  end
end
