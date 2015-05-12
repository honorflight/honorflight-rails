require 'spec_helper'
include Devise::TestHelpers

# http://honorflight-rails.dev/admin/day_of_flight/veterans_branches.json


describe Admin::DayOfFlightsController, type: :controller do
  render_views

  before do
    @admin_user = FactoryGirl.create(:admin_user)
    request.accept = 'application/json'
    request.headers['CONTENT_TYPE'] = 'application/json'
    request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
  end


  describe "get branches" do
    before(:each) do
      @dof = FactoryGirl.create(:day_of_flight, flies_on: Date.tomorrow + 10.days)
      DayOfFlight.should_receive(:next_flight).at_least(:once).and_return(@dof)
      # get :comments, :id => @post.id
    end

    after(:each) do
      @dof.destroy
    end

    it "should render a list of branches on the flight" do
      # DayOfFlight.should_receive(:next_flight).and_return(@dof)
      get :veterans_branches
      expect(response).to be_success
    end
  end


end