class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.text :description
      t.references :rank_type, index: true

      t.timestamps null: false
    end
    add_foreign_key :ranks, :rank_types
  end
end
