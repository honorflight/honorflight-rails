require 'rails_helper'

RSpec.describe War, type: :model do
  it { should have_many(:people) }

  it "should display name with years" do
    war = FactoryGirl.create(:war)
    expect(war.name_with_years).to eql("MyString (2014-2015)")
  end

  it "should return name_with_years in json" do
    war = FactoryGirl.create(:war)
    expect(war.as_json["name_with_years"]).to eql(war.name_with_years)
  end

  it "should return abbreviation_with_years in json" do
    war = FactoryGirl.create(:war)
    expect(war.as_json["abbreviation_with_years"]).to eql(war.abbreviation_with_years)
  end
end
