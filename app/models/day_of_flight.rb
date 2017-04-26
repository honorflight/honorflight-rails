class DayOfFlight < ActiveRecord::Base
  has_many :people
  has_many :veterans
  # has_many :guardians, through: :veterans, foreign_key: :guardian_id
  has_many :flight_details
  has_many :day_of_flights_volunteers
  has_many :volunteers, through: :day_of_flights_volunteers
  has_many :flight_attachments
  has_many :sms_messages

  belongs_to :war

  validates :flies_on, presence: true

  accepts_nested_attributes_for :flight_details, :allow_destroy => true
  accepts_nested_attributes_for :day_of_flights_volunteers, allow_destroy: true
  accepts_nested_attributes_for :flight_attachments, allow_destroy: true

  after_save :schedule_notification
  def schedule_notification
    require "resolv-replace.rb"
    if self.flies_on_changed?
      begin
        update_column(:notification_key, DofNotificationWorker.perform_at(notify_at, id))
      rescue Redis::CannotConnectError
        logger.warn "Redis is not installed or not turned on.  Please install and configure Redis for flight notifications."
      end
    end
  end

  # t.date     "flies_on"
  # t.integer  "war_id"
  # t.text     "special_instruction"
  # t.datetime "created_at",          null: false
  # t.datetime "updated_at",          null: false
  # t.string   "group_number"
  # t.integer  "tickets_purchased"

  def to_s
    self.flies_on.to_s(:aa_long)
  end

  def dof_title
    "Day of Flight #{to_s}"
  end

  def airline_names
    flight_details.map(&:airline).map(&:name).uniq.join(", ")
  end

  def guardians
    veterans.map(&:guardian).compact
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
    volunteers.map(&:text_phone).compact
  end

  def guardians_phones
    guardians.compact.map(&:text_phone).compact
  end

  def volunteers_guardians_phones
    volunteers_phones.concat(guardians_phones)
  end

  def build_welcome_for_volunteer
    response = {}
    response[:numbers] = volunteers_phones
    response[:message] = "Welcome to Greater St. Louis Honor Flight. Replying to this message will send all Guardians and Volunteers the message. Please use for important broadcasts only."

    send_sms(response)
  end

  def build_welcome_for_guardian
    response = {}
    response[:numbers] = guardians_phones
    response[:message] = "Welcome to Greater St. Louis Honor Flight.  Thank you for flying with our veterans. If for any reason you need to reach the flight volunteers, reply to this message. In the case of medical emergency, please dial 911."

    send_sms(response)
  end

  def build_response_from_sms(sms_message)
    response = {}
    if sms_message.person.class == Volunteer
      response[:numbers] = volunteers_guardians_phones
      response[:message] = "(#{role_short_code(sms_message.person.id)}) #{sms_message.person.text_name}: #{sms_message.body}"
    else
      response[:numbers] = volunteers_phones
      response[:message] = "(Guard) #{sms_message.person.text_name}:#{sms_message.person.cell_phone}, (Vet) #{sms_message.person.veteran.text_name}: #{sms_message.body}"
    end

    send_sms(response)
  end

  def send_sms(response)
    response[:numbers].each do |number|
      # SmsJob.new.async.send_sms(number: number, message: response[:message])
      SmsWorker.perform_async(number: number, message: response[:message])
    end
    response
  end


  #TODO: Spec this, then refactor it... #jeesh
  def role_short_code(person_id)
    self.day_of_flights_volunteers.where(person_id: person_id).first.flight_responsibility.role.short_code
  end

  def is_notifiable?
    [Date.today, Date.yesterday, Date.tomorrow].include?(flies_on)
  end

  def notify_at
    self.flies_on.at_midnight - 6.hours
  end

  def veterans_branches
    self.veterans.map { |vet| vet.branches.map(&:name) }.flatten
  end

  class << self
    def current
      where(flies_on: Date.yesterday.beginning_of_day..Date.tomorrow.end_of_day).first
    end

    def next_months(months = 1)
      where(flies_on: Date.yesterday..(Date.today + months.months + 1.day))
    end

    def next_flight
      next_months(6).order(flies_on: :asc).first
    end
  end
end
