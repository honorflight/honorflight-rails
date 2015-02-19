class API::V1::AwardsController < ApplicationController
  def index
    @awards = Award.all()

    render :json => @awards
  end
end
