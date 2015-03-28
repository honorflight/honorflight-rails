class ContactCategory < ActiveRecord::Base
  has_many :contacts

  class << self
    def default
      where(name: "Alternate").first
    end
  end
end
