require 'rails_helper'

RSpec.describe API::V1::SimplePagesController, type: :controller do
  before do
    FactoryGirl.create(:simple_page, key: "test_page")
  end

  it 'return a simple page' do
    get :show, key: "test_page"

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json["html"]).to eql("<p>MyText</p>\n")
  end

end
