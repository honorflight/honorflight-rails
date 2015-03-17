class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :encrypted_relationship
      t.references :address, index: true
      t.references :person, index: true
      t.string :encrypted_phone
      t.string :encrypted_alternate_phone
      t.string :encrypted_email

      t.timestamps null: false
    end
    add_foreign_key :contacts, :addresses
    add_foreign_key :contacts, :people
  end
end
