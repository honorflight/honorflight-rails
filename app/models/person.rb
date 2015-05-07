include ActionView::Helpers::NumberHelper

class Person < ActiveRecord::Base
  attr_encrypted :email, :work_email, :phone, :work_phone, :cell_phone, key: ENV['ENCRYPTION_KEY_PERSON']
  attr_encrypted :birth_date, key: ENV['ENCRYPTION_KEY_PERSON'], marshal: true, marshaler: Marshel::Date

  has_many :service_histories
  has_many :service_awards, through: :service_histories
  
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
  validates :phone, presence: true
  validates :type, presence: true

  # validates :phone_or_email

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :service_histories, allow_destroy: true
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :service_awards
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

# after_save :store_avatar!
# before_save :write_avatar_identifier
  # after_save :store_attachment!
  # def store_attachment!
  #   binding.remote_pry
  #   super
  # end
  def text_phone
    "+1" + cell_phone.gsub(/[^0-9]*/, "")
  end

  def phone
    number_to_phone(self.class.decrypt_phone(self[:encrypted_phone]), area_code: true)
  end

  def phone=(p)
    self[:encrypted_phone] = self.class.encrypt_phone(wash_phone(p))
  end

  def cell_phone
    number_to_phone(self.class.decrypt_cell_phone(self[:encrypted_cell_phone]), area_code: true)
  end

  def cell_phone=(p)
    self[:encrypted_cell_phone] = self.class.encrypt_cell_phone(wash_phone(p))
  end

  def work_phone
    number_to_phone(self.class.decrypt_work_phone(self[:encrypted_work_phone]), area_code: true)
  end

  def work_phone=(p)
    self[:encrypted_work_phone] = self.class.encrypt_work_phone(wash_phone(p))
  end

  def text_name
    "#{first_name[0].upcase}. #{last_name.capitalize}"
  end

  #def flight_date
    #self[:application_date]
    #:day_of_flight[:group_number]


  #end

private 
  def wash_phone(p)
    p.gsub!(/\s?x.*$/, "")
    p.gsub!(/[^0-9]*/, "")
    p.gsub!(/^1/, "") if p.length == 11
    p
  end
end

