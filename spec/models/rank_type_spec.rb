require 'rails_helper'

RSpec.describe RankType, type: :model do
  it { should have_many(:ranks) }
end
