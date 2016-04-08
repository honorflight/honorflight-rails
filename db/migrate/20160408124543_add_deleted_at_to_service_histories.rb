class AddDeletedAtToServiceHistories < ActiveRecord::Migration
  def change
    add_column :service_histories, :deleted_at, :datetime
    add_index :service_histories, :deleted_at
  end
end
