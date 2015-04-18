class AddPhonesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :encrypted_cell_phone, :string
    add_column :people, :encrypted_work_phone, :string
  end
end
