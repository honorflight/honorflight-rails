module API
  module V1
    class RanksController < ApplicationController
      def index
        @ranks = Rank.all

        render :json => @ranks
      end
    end
  end
end