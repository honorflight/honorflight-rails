class API::V1::RankTypesController < ApplicationController
  def index
    @rank_types = RankType.all()

    render :json => @rank_types.to_json(include: :ranks) 
  end
end