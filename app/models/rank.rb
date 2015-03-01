class Rank < ActiveRecord::Base
  belongs_to :rank_type
  belongs_to :branch

  validates :branch, presence: true
  validates :rank_type, presence: true
end
