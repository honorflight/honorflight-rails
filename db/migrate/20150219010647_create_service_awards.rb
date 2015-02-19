class CreateServiceAwards < ActiveRecord::Migration
  def change
    create_table :service_awards do |t|
      t.integer :quantity
      t.text :comment
      t.references :service_history, index: true
      t.references :award, index: true

      t.timestamps null: false
    end
    add_foreign_key :service_awards, :service_histories
    add_foreign_key :service_awards, :awards
  end
end
