require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should have_many(:people)}
end
