class Person < ActiveRecord::Base
  has_many :service_histories
  has_many :service_awards, through: :service_histories
  has_one :address
  has_many :medical_conditions
  belongs_to :war

  validates_presence_of :uuid
  validates :birth_date, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, if: ->{self[:phone].blank?}
  validates :phone, presence: true, if: ->{self[:email].blank?}

  # validates :phone_or_email

  before_validation :generate_uuid, on: :create
  def generate_uuid
    self[:uuid]=SecureRandom.uuid
  end
end
