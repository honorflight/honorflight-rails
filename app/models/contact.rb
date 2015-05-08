include ActionView::Helpers::NumberHelper
include ApplicationHelper

class Contact < ActiveRecord::Base
  attr_encrypted :phone, :email, :alternate_phone, key: ENV['ENCRYPTION_KEY_CONTACT']
  belongs_to :contact_relationship
  belongs_to :address

  belongs_to :person
  belongs_to :contact_category

  before_validation :set_contact_category
  def set_contact_category
    if self[:contact_category_id].blank?
      self[:contact_category_id] = ContactCategory.try(:default).id
    end
  end

  validates :contact_category, presence: true

  accepts_nested_attributes_for :address

  def phone
    number_to_phone(self.class.decrypt_phone(self[:encrypted_phone]), area_code: true)
  end

  def phone=(p)
    self[:encrypted_phone] = self.class.encrypt_phone(wash_phone(p))
  end

  def alternate_phone
    number_to_phone(self.class.decrypt_alternate_phone(self[:encrypted_alternate_phone]), area_code: true)
  end

  def alternate_phone=(p)
    self[:encrypted_alternate_phone] = self.class.encrypt_alternate_phone(wash_phone(p))
  end

  def as_json(options={})
    super(:only => [:id, :full_name, :email, :phone, :alternate_phone])
  end

end
