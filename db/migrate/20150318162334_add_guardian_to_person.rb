class AddGuardianToPerson < ActiveRecord::Migration
  def change
    add_column :people, :guardian, :boolean
  end
end
