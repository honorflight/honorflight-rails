class ServiceHistory < ActiveRecord::Base
  belongs_to :branch
  belongs_to :rank
  belongs_to :rank_type
  belongs_to :person

  has_many :service_awards
  has_many :awards, through: :service_awards
end
