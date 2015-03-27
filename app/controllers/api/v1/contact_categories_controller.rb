class API::V1::ContactCategoriesController < ApplicationController
  def index
    @contact_categories = ContactCategory.all()

    render :json => @contact_categories
  end
end
