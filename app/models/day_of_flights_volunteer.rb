class DayOfFlightsVolunteer < ActiveRecord::Base
  belongs_to :day_of_flight
  belongs_to :volunteer
end
