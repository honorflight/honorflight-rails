require 'rails_helper'

RSpec.describe ContactCategory, type: :model do
  it {should have_many(:contacts)}

  it "should #default be Alternate" do
    FactoryGirl.create(:contact_category, name: "Alternate")
    expect(ContactCategory.default).to eql(ContactCategory.last)
  end
end
