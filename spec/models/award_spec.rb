require 'rails_helper'

RSpec.describe Award, type: :model do
  it { should have_many(:service_awards) }
  it { should have_many(:service_histories).through(:service_awards) }
  it { should belong_to(:branch) }
end
