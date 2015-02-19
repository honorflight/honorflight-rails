class Award < ActiveRecord::Base
	has_many :service_awards
	has_many :service_histories, through: :service_awards
end
