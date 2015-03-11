class AddReleaseToPerson < ActiveRecord::Migration
  def change
    add_column :people, :release_info, :boolean
  end
end
