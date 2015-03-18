require 'rails_helper'

RSpec.describe PersonStatus, type: :model do
  it { should have_many(:people)}
end
