require 'rails_helper'

RSpec.describe Person, type: :model do
  describe "#uuid" do
    subject(:person) { FactoryGirl.create(:person) }
    it "assigns a uuid" do
      expect(person.uuid.length).to be_between(20, 200)
    end
  end
end
