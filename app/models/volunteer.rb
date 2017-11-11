class Volunteer < Person
  has_many :day_of_flights_volunteers, foreign_key: "person_id"
  has_many :day_of_flights, through: :day_of_flights_volunteers

  has_many :volunteers_roles, foreign_key: "person_id"
  has_many :roles, through: :volunteers_roles

  accepts_nested_attributes_for :volunteers_roles, allow_destroy: true

  # validates :cell_phone, presence: true

  def self.in_volunteer_role(role_id)
    # Map the IDs
    volunteers = VolunteersRole.where(role_id: role_id).map(&:person_id)

    where(id: volunteers).order(:last_name)
  end
end
