class Address < ActiveRecord::Base
  attr_encrypted :street1, :street2, key: :encryption_key

  belongs_to :person
  belongs_to :contact


  def to_s
    address = ""
    address += self.street1 unless self.street1.blank?
    address += ", " + self.street2 unless self.street2.blank?
    address += ", " + self.city unless self.city.blank?
    address += ", " + self.state unless self.state.blank?
    address += ". " + self.zipcode unless self.zipcode.blank?
    address
  end
end
