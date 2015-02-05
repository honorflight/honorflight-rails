class Person < ActiveRecord::Base
  validates_presence_of :uuid

  before_validation :generate_uuid, on: :create
  def generate_uuid
    self[:uuid]=SecureRandom.uuid
  end
end
