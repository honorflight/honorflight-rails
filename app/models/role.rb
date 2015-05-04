class Role < ActiveRecord::Base
  has_many :volunteers_roles
  has_many :volunteers, through: :volunteers_roles
  has_many :flight_responsibilities

  validates_length_of :short_code, maximum: 6
end
