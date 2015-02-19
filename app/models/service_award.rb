class ServiceAward < ActiveRecord::Base
  belongs_to :service_history
  belongs_to :award
end
