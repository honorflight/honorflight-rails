require 'rails_helper'

RSpec.describe API::V1::ServiceAwardsController, type: :controller do
  before do
		@admin_user = FactoryGirl.create(:admin_user)
		request.accept = 'application/json'
		request.headers['CONTENT_TYPE'] = 'application/json'
		request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
		@service_history = FactoryGirl.create(:service_history)
		@service_history.service_awards = FactoryGirl.create_list(:service_award, 10)
		@award_id = @service_history.service_awards.last.id
  end

  it 'return a list' do
    get :index, service_history_id: @service_history.id
    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json.length).to eq(10) # check to make sure the right amount of messages are returned
    expect(json[0]["name"]).to eq("Custom Name")
  end

  it 'deletes the award' do
  	delete :destroy, id: @award_id
  	get :index, service_history_id: @service_history.id
  	json = JSON.parse(response.body)
  	expect(json.length).to eq(9)
  end
end
