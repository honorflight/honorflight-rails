class CreateShirtSizes < ActiveRecord::Migration
  def change
    create_table :shirt_sizes do |t|
      t.string :name
      t.string :abbreviation
      t.text :description

      t.timestamps null: false
    end
  end
end
