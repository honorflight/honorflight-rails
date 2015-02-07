require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { should belong_to(:rank_type) }
end
