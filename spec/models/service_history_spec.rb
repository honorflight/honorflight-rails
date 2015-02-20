require 'rails_helper'

RSpec.describe ServiceHistory, type: :model do
  # it { should belong_to(:person) }
  it { should have_many(:service_awards) }
  it { should have_many(:awards).through(:service_awards) }
end
