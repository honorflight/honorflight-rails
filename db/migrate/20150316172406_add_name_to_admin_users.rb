class AddNameToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :first_name, :string
    add_column :admin_users, :last_name, :string
    add_column :admin_users, :phone, :string
  end
end
