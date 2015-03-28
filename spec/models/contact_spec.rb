require 'rails_helper'

RSpec.describe Contact, type: :model do
  before :each do
    FactoryGirl.create(:contact_category, name: "Alternate")
  end

  it { should belong_to(:person)}
  it { should belong_to(:contact_relationship)}
  it { should belong_to(:contact_category)}

  describe "#set_contact_category" do
    it "should default to alternate contact" do
      expect(FactoryGirl.create(:contact).contact_category.name).to eql("Alternate")
    end
  end
end
