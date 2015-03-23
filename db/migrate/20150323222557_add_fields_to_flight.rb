class AddFieldsToFlight < ActiveRecord::Migration
  def change
    add_column :flights, :group_number, :string
    add_column :flights, :tickets_purchased, :integer
  end
end
