class AddShortCodeToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :short_code, :string
  end
end
