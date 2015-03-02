class API::V1::ServiceHistoriesController < SessionController
	before_filter :set_person, only: [:create]
	before_filter :set_service_history, only: [:update]

  # POST /people/:person_id/service_histories
  # POST /people/:person_id/service_histories.json
  def create
  	@service_history =  ServiceHistory.create(service_history_params)
  	if @person.service_histories << @service_history
  		render :json => @service_history
    # No invalid routes right now
  	# else
  	# 	render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /service_histories/1
  # # PATCH/PUT /service_histories/1.json
  def update
    if @service_history.update_attributes(service_history_params)
      render :json => @service_history
    # no invalid routes right now
    # else
    #   render json: @service_history.errors, status: :unprocessable_entity
    end

  end

  private
  def set_person
    @person = Person.find(params[:person_id])
  end

  def service_history_params
    params.require(:service_history).permit(:start_year, :end_year, :activity, :story, :branch_id, :rank_type_id, :rank_id, service_awards_attributes: [:quantity, :comment, :award_id, :id])
      # :first_name, :last_name, :middle_name, :email, :phone, :birth_date, :war_id, :shirt_size_id, address_attributes: [:street1, :city, :state, :zipcode])
  end
  def set_service_history
  	@service_history ||= ServiceHistory.find(params[:id])
  end
end
