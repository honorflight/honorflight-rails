require 'rails_helper'

RSpec.describe API::V1::ContactsController, type: :controller do
  before do
    @admin_user = FactoryGirl.create(:admin_user)
    request.accept = 'application/json'
    request.headers['CONTENT_TYPE'] = 'application/json'
    request.headers["HTTP_X_ADMIN_APIKEY"] = @admin_user.apikey
    @person = FactoryGirl.create(:person)
  end

  # Create
  it 'creates a person\'s contact' do
    post :create, person_id: @person.id, contact: FactoryGirl.attributes_for(:contact, contact_category_id: FactoryGirl.create(:contact_category).id, address_attributes: FactoryGirl.attributes_for(:address))

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json["id"]).to be_a(Integer)
    expect(json["full_name"]).to eql("MyString")
  end

  # Update
  it 'updates a person\'s contact' do
    contact = FactoryGirl.create(:contact, contact_category: FactoryGirl.create(:contact_category))
    attr = { full_name: "other_activititities" }
    put :update, id: contact.id, contact: attr
    contact.reload

    expect(response).to be_success
    expect(contact.full_name).to eql(attr[:full_name])
  end

end
