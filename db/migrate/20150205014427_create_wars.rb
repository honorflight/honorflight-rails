class CreateWars < ActiveRecord::Migration
  def change
    create_table :wars do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps null: false
    end
  end
end
