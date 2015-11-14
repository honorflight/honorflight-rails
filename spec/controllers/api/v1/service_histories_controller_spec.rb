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

  it 'creates a person\'s service history with predefined award' do
    award = FactoryGirl.create(:award)
    service_history = FactoryGirl.attributes_for(:service_history, service_awards_attributes: [FactoryGirl.attributes_for(:service_award, award_id: award.id)])

    post :create, person_id: @person.id, service_history: service_history
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(ServiceHistory.find(json["id"]).service_awards.length).to eql(1)
    expect(json["id"]).to be_a(Integer)
  end

  it 'creates a person\'s service history with predefined award' do
    award = FactoryGirl.create(:award)
    service_history = FactoryGirl.attributes_for(:service_history, service_awards_attributes: [FactoryGirl.attributes_for(:service_award, award_id: award.id, name: "Custom Name")])

    post :create, person_id: @person.id, service_history: service_history
    expect(response).to be_success
    json = JSON.parse(response.body)
    sh = ServiceHistory.find(json["id"])
    expect(sh.service_awards.length).to eql(1)
    sa = sh.service_awards.first
    expect(sa.name).to eql(award.name)
    expect(json["id"]).to be_a(Integer)
  end

  it 'creates a person\'s service history with custom award' do
    service_history = FactoryGirl.attributes_for(:service_history, service_awards_attributes: [FactoryGirl.attributes_for(:service_award, award_id: nil, name: "Custom Name")])

    post :create, person_id: @person.id, service_history: service_history
    expect(response).to be_success
    json = JSON.parse(response.body)
    sh = ServiceHistory.find(json["id"])
    expect(sh.service_awards.length).to eql(1)
    sa = sh.service_awards.first
    expect(sa.name).to eql("Custom Name")
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
