class AddVeteranIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :veteran_id, :integer
  end
end
