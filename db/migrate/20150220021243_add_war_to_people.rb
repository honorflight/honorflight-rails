class AddWarToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :war, index: true
    add_foreign_key :people, :wars
  end
end
