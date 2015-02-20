require 'rails_helper'

RSpec.describe API::V1::MedicalConditionNamesController, type: :controller do
  before do
  	FactoryGirl.create_list(:medical_condition_name, 10)
  end

  it 'return a list' do
    get :index

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json.length).to eq(10) # check to make sure the right amount of messages are returned
  end

end
