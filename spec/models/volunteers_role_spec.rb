require 'rails_helper'

RSpec.describe VolunteersRole, type: :model do
  it { should belong_to(:volunteers)}
  it { should belong_to(:roles)}
end
