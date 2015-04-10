class Role < ActiveRecord::Base
  has_many :volunteers_roles
  has_many :volunteers, through: :volunteers_roles
  has_many :flight_responsibilities
end
