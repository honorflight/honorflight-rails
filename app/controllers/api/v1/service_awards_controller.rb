class API::V1::ServiceAwardsController < SessionController
	before_filter :set_service_history, only: [:index]
	before_filter :set_service_award, only: [:destroy]

	# GET /service_histories/:service_history_id/service_awards
	# GET /service_histories/:service_history_id/service_awards.json
	def index
    render :json => @service_history.service_awards.to_json(only: [:id, :name, :quantity, :description])
	end

	def destroy
		if @service_award.destroy
			render :json => {id: params[:id], status: "Deleted"}
		end
	end

	private
	def set_service_history
		@service_history ||= ServiceHistory.find(params[:service_history_id])
	end

	def set_service_award
		@service_award ||= ServiceAward.find(params[:id])
	end
end
