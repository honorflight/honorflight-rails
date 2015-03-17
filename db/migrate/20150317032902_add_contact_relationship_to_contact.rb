class AddContactRelationshipToContact < ActiveRecord::Migration
  def change
    add_reference :contacts, :contact_relationship, index: true
    add_foreign_key :contacts, :contact_relationships
  end
end
