require 'rails_helper'

RSpec.describe Guardian, type: :model do
  it { should validate_presence_of(:first_name)}

  describe "text_phone number" do
    it "should have a text cleansed number" do
      x = FactoryGirl.create(:guardian, :cell_phone => "314-555-1212")

      expect(x.text_phone).to eql("13145551212")
    end
  end

  describe "text_name" do
    it "should return name in F. Lastname format" do
      x = FactoryGirl.create(:guardian, :first_name => "Jeff", :last_name => "Ancel")
      expect(x.text_name).to eql("J. Ancel")
    end
  end
end