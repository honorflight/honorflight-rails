class AddApikeyToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :apikey, :string, index: true
  end
end
