class API::V1::WarsController < ApplicationController
  def index
    @wars = War.all

    render :json => @wars 
  end
end