class AddAbbreviationToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :abbreviation, :string
  end
end
