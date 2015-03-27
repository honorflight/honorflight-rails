require 'rails_helper'

RSpec.describe API::V1::PeopleController, type: :controller do
	describe "authenticated" do
    before do
      @admin_user = FactoryGirl.create(:admin_user)
      request.accept = 'application/json'
      request.headers['CONTENT_TYPE'] = 'application/json'
      request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
    end

    # Create POST /api/v1/people
    it 'creates a person' do
      post :create, person: FactoryGirl.attributes_for(:person)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["id"]).to be_a(Integer)
      expect(json["applied_online"]).to be(true)
      expect(Person.last.veteran?).to eql(true)
    end

    # Create POST /api/v1/people
    it 'creates a veteran' do
      post :create, person: FactoryGirl.attributes_for(:person, type: nil)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["id"]).to be_a(Integer)
      expect(json["applied_online"]).to be(true)
      expect(Person.last.veteran?).to eql(true)
    end

    it 'catches validation errors' do
      invalid_person = FactoryGirl.attributes_for(:person)
      invalid_person["birth_date"] = nil
      post :create, :person => invalid_person

      expect(response.status).to eq(422)
    end

		# Update PUT /api/v1/people/:id
    describe "PUT update/:id" do
      let(:attr) do
        { first_name: 'other', last_name: 'freak' }
      end

      before(:each) do
        @person = FactoryGirl.create(:person)
        put :update, :id => @person.id, person: attr
        @person.reload
      end

      it { expect(response).to be_success }
      it { expect(@person.first_name).to eql attr[:first_name] }
      it { expect(@person.last_name).to eql attr[:last_name] }
    end

    # Update PUT /api/v1/people/:id
    describe "PUT update/:id invalid" do
      let(:attr) do
        { first_name: nil, last_name: 'freak' }
      end

      before(:each) do
        @person = FactoryGirl.create(:person)
        put :update, :id => @person.id, person: attr
        @person.reload
      end

      it { expect(response.status).to eq(422) }
    end

	end

  describe "unauthenticated" do
    before do
      request.accept = 'application/json'
      request.headers['CONTENT_TYPE'] = 'application/json'
    end

    # Create
    it 'creates a person' do
      post :create, person: FactoryGirl.attributes_for(:person).to_json

      expect(response).to be_redirect
    end
  end
end
