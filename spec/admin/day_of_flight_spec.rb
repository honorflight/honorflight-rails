require 'rails_helper'



RSpec.describe 'DayOfFlight' do

  let(:resource_class) { DayOfFlight }
  let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
  let(:resource)       { all_resources[resource_class] }

  it { expect(resource.resource_name).to eql("DayOfFlight") }


  # describe "authenticated" do
  #   before do
  #     @admin_user = FactoryGirl.create(:admin_user)
  #     request.accept = 'application/json'
  #     request.headers['CONTENT_TYPE'] = 'application/json'
  #     request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
  #   end
  # end

  # http://honorflight-rails.dev/admin/day_of_flight/1/veterans_branches.json

end