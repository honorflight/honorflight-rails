require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should belong_to(:person)}
  it { should belong_to(:contact_relationship)}
  it { should belong_to(:contact_category)}

  it { should validate_presence_of(:contact_category)}
end
