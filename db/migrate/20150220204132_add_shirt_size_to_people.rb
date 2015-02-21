class AddShirtSizeToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :shirt_size, index: true
    add_foreign_key :people, :shirt_sizes
  end
end
