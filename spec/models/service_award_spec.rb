require 'rails_helper'

RSpec.describe ServiceAward, type: :model do
  it { should belong_to(:service_history) }
  it { should belong_to(:award) }

  it { should validate_presence_of(:quantity)}
  it { should validate_inclusion_of(:quantity).in_range(1..100) }
end
