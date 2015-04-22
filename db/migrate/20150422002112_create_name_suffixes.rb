class CreateNameSuffixes < ActiveRecord::Migration
  def change
    create_table :name_suffixes do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
