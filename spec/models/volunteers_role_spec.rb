require 'rails_helper'

RSpec.describe VolunteersRole, type: :model do
  it { should belong_to(:volunteer)}
  it { should belong_to(:role)}
end
