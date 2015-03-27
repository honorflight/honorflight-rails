class Contact < ActiveRecord::Base
  attr_encrypted :phone, :email, :alternate_phone, key: "my key"
  belongs_to :contact_relationship
  belongs_to :address

  belongs_to :person
  belongs_to :contact_category

  validates :contact_category, presence: true

  accepts_nested_attributes_for :address

  def as_json(options={})
    super(:only => [:id, :full_name, :email, :phone, :alternate_phone])
    #.merge(email: self.email, phone: self.phone, alternate_phone: self.alternate_phone)
  end

end
