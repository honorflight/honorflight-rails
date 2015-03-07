class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :encrypted_email
      t.string :encrypted_phone
      t.string :uuid
      t.string :encrypted_birth_date

      t.timestamps null: false
    end
  end
end
