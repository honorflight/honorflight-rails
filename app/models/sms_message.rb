class SmsMessage < ActiveRecord::Base
  belongs_to :day_of_flight
  belongs_to :person

  validates :day_of_flight, presence: true
  validates :body, presence: true
  validates :person, presence: true

  before_validation :set_flight, :set_person
  def set_flight
    if day_of_flight_id.nil?
      day_of_flight = DayOfFlight.current
    end
  end

  def set_person
    return if day_of_flight.nil?
    self[:person_id] = day_of_flight.phone_on_flight(from).try(:id)
  end
end
