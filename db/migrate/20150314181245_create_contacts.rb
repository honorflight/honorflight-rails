class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :company_name
      t.references :address, index: true
      t.string :encrypted_phone
      t.string :encrypted_email

      t.timestamps null: false
    end
    add_foreign_key :contacts, :addresses
  end
end
