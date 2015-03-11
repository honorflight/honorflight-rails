class ServiceAward < ActiveRecord::Base
  belongs_to :service_history
  belongs_to :award

  validates :quantity, presence: true, inclusion: {in: 1..100}
end
