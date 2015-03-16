class AddEmailOnEventToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :email_on_event, :boolean
  end
end
