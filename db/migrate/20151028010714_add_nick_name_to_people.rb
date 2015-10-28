class AddNickNameToPeople < ActiveRecord::Migration
  def change
    add_column :people, :nick_name, :string
  end
end
