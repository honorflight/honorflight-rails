class AddContactCategoryToPeopleContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :contact_category, index: true
    add_foreign_key :contacts, :contact_categories
  end
end
