require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should belong_to(:person)}
  it { should belong_to(:contact_category)}
end
