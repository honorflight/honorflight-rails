class FlightResponsibility < ActiveRecord::Base
  belongs_to :role

  has_many :day_of_flights_volunteers
end
