require 'rails_helper'

RSpec.describe StatusController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to eql("OKAY")
    end
  end

end
