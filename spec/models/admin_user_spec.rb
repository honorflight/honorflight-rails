require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "#apikey" do
    subject(:admin_user) { FactoryGirl.create(:admin_user, email: "test@example.com", password: "example00", password_confirmation: "example00") }
    it "assigns a apikey" do
      expect(admin_user.apikey.length).to be_between(20, 200)
    end
  end
end
