class AddAppliedOnlineToPeople < ActiveRecord::Migration
  def change
    add_column :people, :applied_online, :boolean
  end
end
