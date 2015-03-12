class AddTlcToPerson < ActiveRecord::Migration
  def change
    add_column :people, :tlc, :boolean
  end
end
