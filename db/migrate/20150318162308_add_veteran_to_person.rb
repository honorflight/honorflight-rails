class AddVeteranToPerson < ActiveRecord::Migration
  def change
    add_column :people, :veteran, :boolean
  end
end
