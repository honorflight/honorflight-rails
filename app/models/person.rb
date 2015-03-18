class Person < ActiveRecord::Base
  attr_encrypted :email, :phone, key: :encryption_key
  attr_encrypted :birth_date, key: :encryption_key, marshal: true, marshaler: Marshel::Date

  has_many :service_histories
  has_many :service_awards, through: :service_histories

  has_one :address
  has_many :medical_conditions

  # has_many :people_contacts
  # has_many :contacts, through: :people_contacts

  # has_many :contact_categories, through: :people_contacts

  has_many :contacts

  #has_one :emergency_contacts, -> { where(emergency: true) }, class_name: 'PeopleContact'
  #has_one :emergency_contact, through: :emergency_contacts, source: :contact

  #has_one :alternate_contacts, -> { where(alternate: true) }, class_name: 'PeopleContact'
  #has_one :alternate_contact, through: :alternate_contacts, source: :contact

  #has_one :physician_contacts, -> { where(other: true, other_key: 'physician') }, class_name: 'PeopleContact'
  #has_one :physician_contact, through: :physician_contacts, source: :contact

  # has_one :primary_category, through: :primary_category_relation, source: :category
  # has_many :emergency_contact, through: :people_contacts, source: :contacts
  # has_many :alternate_contact, through: :people_contacts, source: :contacts

  belongs_to :war
  belongs_to :shirt_size
  belongs_to :flight

  validates :uuid, presence: true
  validates :birth_date, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true

  # validates :phone_or_email

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :service_histories, :allow_destroy => true
  accepts_nested_attributes_for :medical_conditions, :allow_destroy => true
  accepts_nested_attributes_for :contacts

  after_create :send_admin_emailers
  def send_admin_emailers
    if SmtpSetting.first.send_mail?
      AdminUser.where(email_on_event: true).each do |admin_user|
        AdminPersonMailer.veteran_form_submission_email(self, admin_user).deliver_later
      end
    end
  end

  before_validation :generate_uuid, on: :create
  def generate_uuid
    self[:uuid]||=SecureRandom.uuid
  end

  def encryption_key
    generate_uuid
  end

  # def birth_date
  #   self[:birth_date].iso8601
  # end

  # protected
  # def build_emergency_contact(options={})
  #   # binding.pry_remote
  # end
end
