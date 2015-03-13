class Person < ActiveRecord::Base
  attr_encrypted :email, :phone, key: :encryption_key
  attr_encrypted :birth_date, key: :encryption_key, marshal: true, marshaler: Marshel::Date

  has_many :service_histories
  has_many :service_awards, through: :service_histories
  has_one :address
  has_many :medical_conditions
  belongs_to :war
  belongs_to :shirt_size
  belongs_to :flight

  validates_presence_of :uuid
  validates :birth_date, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true

  # validates :phone_or_email

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :service_histories
  accepts_nested_attributes_for :medical_conditions

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
end
