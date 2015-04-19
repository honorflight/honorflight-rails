class CreatePeopleAttachments < ActiveRecord::Migration
  def change
    create_table :people_attachments do |t|
      t.references :person, index: true
      t.string :attachment
      t.string :name
      t.string :comments

      t.timestamps null: false
    end
    add_foreign_key :people_attachments, :people
  end
end
