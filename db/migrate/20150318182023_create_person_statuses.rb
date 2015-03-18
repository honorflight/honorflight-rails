class CreatePersonStatuses < ActiveRecord::Migration
  def change
    create_table :person_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
