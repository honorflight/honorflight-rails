class AddPersonStatusToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :person_status, index: true
    add_foreign_key :people, :person_statuses
  end
end
