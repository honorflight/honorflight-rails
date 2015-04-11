class Person < ActiveRecord::Base
  attr_encrypted :email, :phone, key: :encryption_key
  attr_encrypted :birth_date, key: :encryption_key, marshal: true, marshaler: Marshel::Date

  has_many :service_histories
  has_many :service_awards, through: :service_histories
  has_one :address
  has_many :person_status
  has_many :contacts

  belongs_to :war
  belongs_to :shirt_size
  belongs_to :flight
  belongs_to :person_status


  validates :uuid, presence: true
  validates :birth_date, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :type, presence: true

  # validates :phone_or_email

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :service_histories, :allow_destroy => true
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :service_awards

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
end
