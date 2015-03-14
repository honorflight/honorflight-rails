require 'rails_helper'

RSpec.describe PeopleContact, type: :model do
  it { should belong_to(:person)}
  it { should belong_to(:contact)}
end
