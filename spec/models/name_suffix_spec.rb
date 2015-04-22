require 'rails_helper'

RSpec.describe NameSuffix, type: :model do
  it { should have_many(:people)}
end
