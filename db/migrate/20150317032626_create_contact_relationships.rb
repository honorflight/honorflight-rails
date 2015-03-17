class CreateContactRelationships < ActiveRecord::Migration
  def change
    create_table :contact_relationships do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
