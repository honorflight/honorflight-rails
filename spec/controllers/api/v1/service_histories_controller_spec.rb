require 'rails_helper'

RSpec.describe API::V1::ServiceHistoriesController, type: :controller do
	before do
		@admin_user = FactoryGirl.create(:admin_user)
		request.accept = 'application/json'
		request.headers['CONTENT_TYPE'] = 'application/json'
		request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
		@person = FactoryGirl.create(:person)
	end

  # Create
  it 'creates a person\'s service history' do
		post :create, person_id: @person.id, service_history: FactoryGirl.attributes_for(:service_history)

		expect(response).to be_success
		json = JSON.parse(response.body)
		expect(json["id"]).to be_a(Integer)
  end

  # Update
  it 'updates a service history' do
  	service_history = FactoryGirl.create(:service_history)
  	attr = { activity: "other_activititities" }
  	put :update, id: service_history.id, service_history: attr
  	service_history.reload

  	expect(response).to be_success
  	expect(service_history.activity).to eql(attr[:activity])
  end

end
