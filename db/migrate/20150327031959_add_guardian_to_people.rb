class AddGuardianToPeople < ActiveRecord::Migration
  def change
    add_column :people, :guardian_id, :integer, index: true
  end
end
