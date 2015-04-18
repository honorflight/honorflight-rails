class Rank < ActiveRecord::Base
  default_scope { order("#{table_name}.name ASC") }

  belongs_to :rank_type
  belongs_to :branch

  validates :branch, presence: true
  validates :rank_type, presence: true
end
