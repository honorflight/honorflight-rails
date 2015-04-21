class DayOfFlight < ActiveRecord::Base
  has_many :people
  has_many :veterans
  has_many :guardians, through: :veterans
  has_many :flight_details
  has_many :day_of_flights_volunteers
  has_many :volunteers, through: :day_of_flights_volunteers
  has_many :flight_attachments

  belongs_to :war

  validates :flies_on, presence: true

  accepts_nested_attributes_for :flight_details, :allow_destroy => true
  accepts_nested_attributes_for :day_of_flights_volunteers, allow_destroy: true
  accepts_nested_attributes_for :flight_attachments, allow_destroy: true


  # t.date     "flies_on"
  # t.integer  "war_id"
  # t.text     "special_instruction"
  # t.datetime "created_at",          null: false
  # t.datetime "updated_at",          null: false
  # t.string   "group_number"
  # t.integer  "tickets_purchased"

  def to_s
    self.flies_on.to_s(:aa)
  end

  def airline_names
    flight_details.map(&:airline).map(&:name).uniq.join(", ")
  end

  def people_count
    veterans.map(&:guardian_id).count +
    veterans.count +
    volunteers.count
  end
end
