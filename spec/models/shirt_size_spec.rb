require 'rails_helper'

RSpec.describe ShirtSize, type: :model do
  it { should have_many(:people) }
end
