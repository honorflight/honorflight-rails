class AddNameToServiceAwards < ActiveRecord::Migration
  def change
    add_column :service_awards, :name, :string
  end
end
