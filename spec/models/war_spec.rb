require 'rails_helper'

RSpec.describe War, type: :model do
  it { should have_many(:people) }
end
