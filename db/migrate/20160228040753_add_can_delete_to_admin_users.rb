class AddCanDeleteToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :can_delete, :boolean
  end
end
