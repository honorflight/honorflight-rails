class TravelCompanion < ActiveRecord::Base
  belongs_to :travel_companion
  belongs_to :veteran
end
