class ServiceHistory < ActiveRecord::Base
  acts_as_paranoid 
  
  belongs_to :branch
  belongs_to :rank
  belongs_to :rank_type
  belongs_to :person

  has_many :service_awards
  has_many :awards, through: :service_awards

  accepts_nested_attributes_for :service_awards, allow_destroy: true
end
# .service_awards_attributes = [{service_award}, {service_award}]
