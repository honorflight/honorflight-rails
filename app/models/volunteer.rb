class Volunteer < Person
  has_many :day_of_flights_volunteers, foreign_key: "person_id"
  has_many :day_of_flights, through: :day_of_flights_volunteers
end
