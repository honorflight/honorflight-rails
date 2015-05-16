class AddSpecialRequestToPeople < ActiveRecord::Migration
  def change
    add_column :people, :special_request, :text
  end
end
