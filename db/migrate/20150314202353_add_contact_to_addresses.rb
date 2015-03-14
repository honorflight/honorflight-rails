class AddContactToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :contact, index: true
    add_foreign_key :addresses, :contacts
  end
end
