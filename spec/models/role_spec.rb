require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_many(:volunteers).through(:volunteers_roles)}
  it { should have_many(:volunteers_roles)}
end
