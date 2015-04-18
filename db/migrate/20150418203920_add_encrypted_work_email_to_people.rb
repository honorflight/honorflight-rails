class AddEncryptedWorkEmailToPeople < ActiveRecord::Migration
  def change
    add_column :people, :encrypted_work_email, :string
  end
end
