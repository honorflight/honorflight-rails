class AddNameSuffixToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :name_suffix, index: true
    add_foreign_key :people, :name_suffixes
  end
end
