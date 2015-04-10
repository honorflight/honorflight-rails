class CreateVolunteersRoles < ActiveRecord::Migration
  def change
    create_table :volunteers_roles do |t|
      t.references :person, index: true
      t.references :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :volunteers_roles, :people
    add_foreign_key :volunteers_roles, :roles
  end
end
