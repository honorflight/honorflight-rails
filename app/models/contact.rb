class Contact < ActiveRecord::Base
  attr_encrypted :phone, :email, key: "my key"

  has_one :address

  has_many :people_contacts
  has_many :people, through: :people_contacts
end
