require 'rails_helper'

RSpec.describe SuperAdminAuthorization, type: :model do
  it "should validate super admin on :destroy action" do
    @user = FactoryGirl.create(:admin_user, can_delete: true)
    # allow_any_instance_of(SuperAdminAuthorization).to receive(:user).and_return(@user)
    model = SuperAdminAuthorization.new(Veteran, @user)
    expect(model.authorized?(:destroy)).to be_truthy
  end

  it "should validate super admin on :destroy action" do
    @user = FactoryGirl.create(:admin_user)
    # allow_any_instance_of(SuperAdminAuthorization).to receive(:user).and_return(@user)
    model = SuperAdminAuthorization.new(Veteran, @user)
    expect(model.authorized?(:destroy)).to be_falsey
  end

  it "should allow all non :destroy actions" do
    @user = FactoryGirl.create(:admin_user)
    # allow_any_instance_of(SuperAdminAuthorization).to receive(:user).and_return(@user)
    model = SuperAdminAuthorization.new(Veteran, @user)
    expect(model.authorized?(:create)).to be_truthy
    expect(model.authorized?(:update)).to be_truthy
    expect(model.authorized?(:read)).to be_truthy
  end
end
