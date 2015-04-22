class API::V1::NameSuffixesController < ApplicationController
  def index
    @name_suffixes = NameSuffix.all()

    render :json => @name_suffixes
  end
end
