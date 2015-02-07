class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :addresses, :people
  end
end
