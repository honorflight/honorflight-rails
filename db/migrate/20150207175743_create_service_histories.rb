class CreateServiceHistories < ActiveRecord::Migration
  def change
    create_table :service_histories do |t|
      t.date :start_year
      t.date :end_year
      t.string :activity
      t.text :story
      t.references :branch, index: true
      t.references :rank, index: true
      t.references :rank_type, index: true
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :service_histories, :branches
    add_foreign_key :service_histories, :ranks
    add_foreign_key :service_histories, :rank_types
    add_foreign_key :service_histories, :people
  end
end
