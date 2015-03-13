class Airline < ActiveRecord::Base
  has_many :flight_details

  validates :name, presence: true
end
