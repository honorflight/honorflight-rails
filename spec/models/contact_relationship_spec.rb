require 'rails_helper'

RSpec.describe ContactRelationship, type: :model do
  it { should have_many(:contacts)}
end
