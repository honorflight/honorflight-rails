class Flight < ActiveRecord::Base
  has_many :people
  has_many :flight_details
  belongs_to :war

  validates :flies_on, presence: true

  accepts_nested_attributes_for :flight_details, :allow_destroy => true

  def to_s
    self.flies_on.to_s(:aa)
  end
end
