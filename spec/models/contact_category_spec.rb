require 'rails_helper'

RSpec.describe ContactCategory, type: :model do
  it {should have_many(:contacts)}
end
