class API::V1::ShirtSizesController < ApplicationController
  def index
    @shirt_sizes = ShirtSize.all()

    render :json => @shirt_sizes 
  end
end
