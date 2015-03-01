class Branch < ActiveRecord::Base
	has_many :awards
	has_many :ranks
end
