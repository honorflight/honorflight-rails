class ServiceAward < ActiveRecord::Base
  belongs_to :service_history
  belongs_to :award

  validates :quantity, presence: true, inclusion: {in: 1..100}

  before_validation :set_quantity
  def set_quantity
    if self.quantity.blank? || self.quantity > 100 || self.quantity <= 0
      self.quantity = 1
    end
  end
end
