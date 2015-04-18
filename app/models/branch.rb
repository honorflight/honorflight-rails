class Branch < ActiveRecord::Base
  default_scope { order("#{table_name}.name ASC") }

	has_many :awards
	has_many :ranks
end
