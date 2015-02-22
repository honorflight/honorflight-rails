require 'rails_helper'

RSpec.describe API::V1::PeopleController, type: :controller do
	describe "authenticated" do
    before do
      @admin_user = FactoryGirl.create(:admin_user)
      request.accept = 'application/json'
      request.headers['CONTENT_TYPE'] = 'application/json'
      request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
    end

		# Create
		it 'creates a person' do
			post :create, FactoryGirl.attributes_for(:person).to_json

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["id"]).to be_a(Integer)
		end

    it 'catches validation errors' do
      invalid_person = FactoryGirl.attributes_for(:person)
      invalid_person["birth_date"] = nil
      post :create, invalid_person.to_json

      expect(response.status).to eq(422)
    end

		# Update
    describe "PUT update/:id" do
      let(:attr) do 
        { :first_name => 'other', :last_name => 'freak' }
      end

      before(:each) do
        @person = FactoryGirl.create(:person)
        request.env["RAW_POST_DATA"] = attr.to_json
        put :update, :id => @person.id
        @person.reload
      end

      it { expect(response).to be_success }
      it { expect(@person.first_name).to eql attr[:first_name] }
      it { expect(@person.last_name).to eql attr[:last_name] }
    end
	end

  describe "unauthenticated" do
    before do
      request.accept = 'application/json'
      request.headers['CONTENT_TYPE'] = 'application/json'
    end

    # Create
    it 'creates a person' do
      post :create, FactoryGirl.attributes_for(:person).to_json

      expect(response).to be_redirect
    end
  end
end
