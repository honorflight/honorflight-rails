class PeopleContact < ActiveRecord::Base
  belongs_to :person
  belongs_to :contact

  accepts_nested_attributes_for :contact
end
