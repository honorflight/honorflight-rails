class Contact < ActiveRecord::Base
  attr_encrypted :phone, :email, :alternate_phone, key: "my key"
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


  def as_json(options={})
    super(:only => [:id, :full_name, :email, :phone, :alternate_phone])
  end

end
