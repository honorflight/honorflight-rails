class Contact < ActiveRecord::Base
  has_one :address

  has_many :people_contacts
  has_many :people, through: :people_contacts
end
