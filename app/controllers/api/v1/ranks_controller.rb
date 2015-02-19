class API::V1::RanksController < ApplicationController
  def index
    @ranks = Rank.all()

    render :json => @ranks 
  end
end
