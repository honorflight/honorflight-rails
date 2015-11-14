require 'rails_helper'

RSpec.describe ServiceAward, type: :model do
  it { should belong_to(:service_history) }
  it { should belong_to(:award) }

  describe "name with award_id" do
    let(:new_award) { FactoryGirl.create(:award, name: "Custom Award") }
    subject(:award) { FactoryGirl.create(:service_award, award_id: new_award.id, name: "Custom Name") }

    it "should have award name" do
      expect(award.name).to eql("Custom Award")
    end
  end

  describe "name without award_id" do
    subject(:award) { FactoryGirl.create(:service_award, name: "Custom Name") }

    it "should have award name" do
      expect(award.name).to eql("Custom Name")
    end
  end

  describe "quantity" do
    subject(:award) { FactoryGirl.create(:service_award, quantity: nil) }

    it "should default to 1 for any invalid values" do
      expect(award.quantity).to eql 1
    end

    it "should have at least one award if set to -100" do
      award.update_attributes(quantity: -100)
      expect(award.quantity).to eql 1
    end
  end  
end
