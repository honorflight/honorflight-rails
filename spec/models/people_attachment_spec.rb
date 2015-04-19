require 'rails_helper'

RSpec.describe PeopleAttachment, type: :model do
  it { should belong_to(:person)}
end
