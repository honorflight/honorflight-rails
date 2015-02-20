class AddBranchesToAwards < ActiveRecord::Migration
  def change
    add_reference :awards, :branch, index: true
    add_foreign_key :awards, :branches
  end
end
