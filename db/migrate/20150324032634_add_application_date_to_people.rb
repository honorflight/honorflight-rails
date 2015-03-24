class AddApplicationDateToPeople < ActiveRecord::Migration
  def change
    add_column :people, :application_date, :date
  end
end
