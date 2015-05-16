class CreateTravelCompanions < ActiveRecord::Migration
  def change
    create_table :travel_companions do |t|
      t.integer :travel_companion_id, index: true
      t.integer :veteran_id, index: true

      t.timestamps null: false
    end
  end
end
