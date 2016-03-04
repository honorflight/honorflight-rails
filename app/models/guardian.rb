class Guardian < Person
  has_one :veteran, inverse_of: :guardian

  # validates :cell_phone, presence: true

  has_one :day_of_flight, through: :veteran
end