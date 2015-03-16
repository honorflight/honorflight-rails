class PeopleContact < ActiveRecord::Base
  belongs_to :person
  belongs_to :contact
  belongs_to :contact_category

  accepts_nested_attributes_for :contact
end
