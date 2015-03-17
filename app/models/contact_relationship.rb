class ContactRelationship < ActiveRecord::Base
  has_many :contacts
end
