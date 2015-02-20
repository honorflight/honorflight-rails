require 'rails_helper'

RSpec.describe ServiceAward, type: :model do
  it { should belong_to(:service_history) }
  it { should belong_to(:award) }
end
