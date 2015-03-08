class CreateSimplePages < ActiveRecord::Migration
  def change
    create_table :simple_pages do |t|
      t.string :key
      t.string :title
      t.text :markdown

      t.timestamps null: false
    end
  end
end
