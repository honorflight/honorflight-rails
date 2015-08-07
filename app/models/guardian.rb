class Guardian < Person
  has_one :veteran, inverse_of: :guardian

  # validates :cell_phone, presence: true
end