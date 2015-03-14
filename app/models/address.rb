class Address < ActiveRecord::Base
  attr_encrypted :street1, :street2, :key => 'future key alg'

  belongs_to :person
  belongs_to :contact
end
