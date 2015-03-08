class API::V1::SimplePagesController < ApplicationController
  before_filter :set_simple_page, only: [:show]

  def show
    render json: @simple_page
  end

  private
  def set_simple_page
    @simple_page ||= SimplePage.find_by(key: params[:key])
  end
end
