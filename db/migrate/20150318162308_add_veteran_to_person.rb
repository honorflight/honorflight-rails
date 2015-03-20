class AddVeteranToPerson < ActiveRecord::Migration
  def change
    add_column :people, :veteran, :boolean, default: true
  end
end
