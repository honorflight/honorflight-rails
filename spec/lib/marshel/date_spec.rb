require 'rails_helper'

RSpec.describe Marshel::Date do
  describe "#dump" do 
    it "should mot mashel a date string" do
      expect(Marshel::Date.dump("1979-03-20")).to eql("1979-03-20")
    end

    it "marshal a normal date" do
      expect(Marshel::Date.dump(Date.parse("1979-03-20"))).to eql("1979-03-20")
    end

    it "should not dump invalid date" do
      expect(Marshel::Date.dump("some-random-non-parsable date")).to eql(nil)
    end
  end

  describe "#load" do
    it "should load a valid date string" do
      expect(Marshel::Date.load("1979-03-20")).to eql(Date.parse("1979-03-20"))
    end
    it "should gracefully handle invalid date string" do
      expect(Marshel::Date.load("some-random-non-parsable date")).to eql(nil)
    end
  end
end
