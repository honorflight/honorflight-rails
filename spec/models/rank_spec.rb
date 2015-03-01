require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { should belong_to(:rank_type) }
  it { should belong_to(:branch) }
  it { should validate_presence_of(:branch) }
  it { should validate_presence_of(:rank_type) }
end
