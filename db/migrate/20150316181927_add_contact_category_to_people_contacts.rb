class AddContactCategoryToPeopleContacts < ActiveRecord::Migration
  def change
    add_reference :people_contacts, :contact_category, index: true
    add_foreign_key :people_contacts, :contact_categories
  end
end
