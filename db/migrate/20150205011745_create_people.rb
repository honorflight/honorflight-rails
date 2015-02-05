class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :phone
      t.string :uuid
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
