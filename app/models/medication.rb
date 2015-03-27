class Medication < ActiveRecord::Base
  belongs_to :person
  belongs_to :medication_route
end
