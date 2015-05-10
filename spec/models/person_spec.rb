require 'rails_helper'

RSpec.describe Person, type: :model do
  it "should have a factory" do
    expect(FactoryGirl.build(:person)).to be_valid
  end


  it { should have_many(:service_histories) }
  it { should have_one(:address) }
  it { should validate_presence_of(:birth_date) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should belong_to(:war) }
  it { should have_many(:service_awards) }
  it { should belong_to(:shirt_size) }
  it { should belong_to(:day_of_flight)}
  it { should belong_to(:name_suffix)}
  it { should have_many(:contacts)}
  it { should have_many(:people_attachments)}

  it { should accept_nested_attributes_for(:people_attachments)}

  describe "phone" do
    before(:each) do
      @veteran = FactoryGirl.create(:veteran, 
        phone: Faker::PhoneNumber.phone_number, 
        cell_phone: Faker::PhoneNumber.cell_phone, 
        work_phone: Faker::PhoneNumber.phone_number)
    end
    it "should validate phone as 14 digits" do
      expect(@veteran.phone.length).to eql(14)
    end
    it "should validate cell_phone as 14 digits" do
      expect(@veteran.cell_phone.length).to eql(14)
    end
    it "should validate work_phone as 14 digits" do
      expect(@veteran.work_phone.length).to eql(14)
    end
  end
  describe "#uuid" do
    subject(:person) { FactoryGirl.create(:person) }
    it "assigns a uuid" do
      expect(person.uuid.length).to be_between(20, 200)
    end
  end

  describe "#application_date" do
    describe "auto-generated" do
      it "should use created_at" do
        p = FactoryGirl.create(:person)
        expect(p.application_date).to eql(p.created_at.to_date)
      end
    end

    describe "manual-input" do
      it "should not use created_at" do
        p = FactoryGirl.create(:person, application_date: Date.today - 3.days)
        expect(p.application_date).not_to eql(p.created_at.to_date)
      end
    end
  end
end


