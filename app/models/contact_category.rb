class ContactCategory < ActiveRecord::Base
  has_many :people_contacts
  accepts_nested_attributes_for :people_contacts
end
