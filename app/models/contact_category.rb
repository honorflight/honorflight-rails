class ContactCategory < ActiveRecord::Base
  has_many :contacts
end
