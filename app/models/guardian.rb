class Guardian < Person
  has_one :veteran, inverse_of: :guardian
end