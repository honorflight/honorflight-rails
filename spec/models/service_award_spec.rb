require 'rails_helper'

RSpec.describe ServiceAward, type: :model do
  it { should belong_to(:service_history) }
  it { should belong_to(:award) }


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
