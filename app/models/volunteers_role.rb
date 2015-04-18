class VolunteersRole < ActiveRecord::Base
  belongs_to :volunteer, foreign_key: "person_id"
  belongs_to :role
end