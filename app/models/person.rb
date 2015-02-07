class Person < ActiveRecord::Base
  has_many :service_histories
  has_one :address

  validates_presence_of :uuid

  before_validation :generate_uuid, on: :create
  def generate_uuid
    self[:uuid]=SecureRandom.uuid
  end
end
