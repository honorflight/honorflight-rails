class AddVolunteerExpereinceToPeople < ActiveRecord::Migration
  def change
    add_column :people, :learned_about, :text
    add_column :people, :why_volunteer, :text
    add_column :people, :previous_experience, :text
  end
end
