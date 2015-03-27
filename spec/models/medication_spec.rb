require 'rails_helper'

RSpec.describe Medication, type: :model do
  it { should belong_to(:person)}
  it { should belong_to(:medication_route)}
end
