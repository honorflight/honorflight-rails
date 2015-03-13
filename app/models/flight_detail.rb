class FlightDetail < ActiveRecord::Base
  belongs_to :airline
  belongs_to :flight

  validates :arrival_gate, presence: true
  validates :departure_gate, presence: true
  validates :flight_number, presence: true
  validates :airline, presence: true
  validates :departs_at, presence: true
  validates :arrives_at, presence: true
  validates :departs_from, presence: true
  validates :destination, presence: true
end
