class API::V1::ContactRelationshipsController < ApplicationController
  def index
    @contact_relationships = ContactRelationship.all()

    render :json => @contact_relationships
  end
end
