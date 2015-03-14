class AddBeginAndEndYearsToWars < ActiveRecord::Migration
  def change
    add_column :wars, :begin_year, :date
    add_column :wars, :end_year, :date
  end
end
