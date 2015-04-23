class DayOfFlight < ActiveRecord::Base
  has_many :people
  has_many :veterans
  # has_many :guardians, through: :veterans, foreign_key: :guardian_id
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
    self.flies_on.to_s(:long)
  end

  def airline_names
    flight_details.map(&:airline).map(&:name).uniq.join(", ")
  end

  def guardians
    veterans.map(&:guardian)
    # veterans.map() { |v| v.guardian_id }
  end

  def people_count
    guardians.count +
    veterans.count +
    volunteers.count
  end

  def phone_on_flight(in_phone)
    guardians.each do |guardian|
      return guardian if guardian.text_phone == in_phone
    end

    volunteers.each do |volunteer|
      return volunteer if volunteer.text_phone == in_phone
    end
    nil
  end

  def volunteers_phones
    volunteers.map(&:text_phone)
  end

  def guardians_phones
    guardians.map(&:text_phone)
  end

  def volunteers_guardians_phones
    volunteers_phones.concat(guardians_phones)
  end

  def build_response(number, message = nil)
    if person = phone_on_flight(number)
      # Build hash with list of numbers and a message to send
      if person.class == Volunteer
        response = { numbers: volunteers_guardians_phones,
          message: "(Vol) #{person.text_name}: #{message}"
        }
      elsif person.class == Guardian
        response = { numbers: volunteers_phones, 
          message: "(G) #{person.text_name}, (V) #{person.veteran.text_name}: #{message}" }
      end
    else
      # Respond with not-availabe message
      response = { numbers: [number], message: "This number is not available for texting right now. Please try later."}
    end

    # Return messages sscheduled count???
    response
  end
end
