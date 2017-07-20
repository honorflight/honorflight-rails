include ActionView::Helpers::NumberHelper
include ApplicationHelper

class Person < ActiveRecord::Base
  acts_as_paranoid

  attr_encrypted :email, :work_email, :phone, :work_phone, :cell_phone, key: ENV['ENCRYPTION_KEY_PERSON']
  attr_encrypted :birth_date, key: ENV['ENCRYPTION_KEY_PERSON'], marshal: true, marshaler: Marshel::Date

  has_many :service_histories
  has_many :service_awards, through: :service_histories
  has_many :branches, through: :service_histories
  
  has_one :address
  has_many :person_status
  has_many :contacts

  has_many :people_attachments

  has_many :sms_messages

  belongs_to :war
  belongs_to :shirt_size
  belongs_to :day_of_flight
  belongs_to :person_status
  belongs_to :name_suffix

  validates :uuid, presence: true
  validates :birth_date, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :type, presence: true

  validate :phone_xor_cell_phone
  def phone_xor_cell_phone
    if phone.blank? && cell_phone.blank?
      errors.add(:base, "Phone or cell phone can't be blank")
    end
  end

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :service_histories, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :service_awards, allow_destroy: true
  accepts_nested_attributes_for :people_attachments, allow_destroy: true

  after_create :send_admin_emailers
  def send_admin_emailers
    @smtp_setting ||= SmtpSetting.first

    return if @smtp_setting.blank? || !@smtp_setting.send_mail?

    AdminUser.where(email_on_event: true).each do |admin_user|
      AdminPersonMailer.veteran_form_submission_email(self, admin_user).deliver_later
    end
  end

  before_validation :generate_uuid, on: :create
  def generate_uuid
    self[:uuid]||=SecureRandom.uuid
  end

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

  def application_date
    self[:application_date] || self[:created_at].try(:to_date)
  end

  def text_phone
    return nil if cell_phone.blank?
    "+1" + cell_phone.gsub(/[^0-9]*/, "")
  end

  ["cell_", "work_", ""].each do |phone|
    define_method("#{phone}phone") do 
      number_to_phone(self.class.send("decrypt_#{phone}phone", self["encrypted_#{phone}phone".to_sym]), area_code: true)
    end

    define_method("#{phone}phone=") do |p|
      self["encrypted_#{phone}phone".to_sym] = self.class.send("encrypt_#{phone}phone", wash_phone(p))
    end
  end

  def text_name
    "#{first_name[0].upcase}. #{last_name.capitalize}"
  end

  def age
    # return if self.birth_date.empty?
    dob = self.birth_date
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  class << self
    def in_months(n = 2)
      where(created_at: (Date.today.beginning_of_month - n.months)..DateTime.now).group("DATE_TRUNC('month', created_at)").group(:type).count
    end

    def applications_by_date
      data = in_months

      data.inject({}) do |result, elem|
        elem.flatten!
        m = elem[0].strftime("%B")
        stats = {elem[1] => elem[2]}

        result[m] ? result[m].push(stats) : result[m] = [stats]

        result
      end
    end
  end



  # def birth_date

  #   # formatDate(self.class.decrypt_birth_date(self[:encrypted_birth_date]))
  # end

  # def updated_at
  #   formatDateTime(self[:updated_at])
  # end

end
