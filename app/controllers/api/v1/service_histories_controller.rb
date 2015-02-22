class API::V1::ServiceHistoriesController < SessionController
	before_filter :set_person, only: [:create]
	before_filter :set_service_history, only: [:update]

  # POST /people/:person_id/service_histories
  # POST /people/:person_id/service_histories.json
  def create
  	@service_history =  ServiceHistory.create(request_body)
  	if @person.service_histories << @service_history
  		render :json => @service_history
  	else
  		render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /service_histories/1
  # # PATCH/PUT /service_histories/1.json
  def update
    if @service_history.update_attributes(request_body)
      render :json => @service_history
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end

  end

  private
  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_service_history
  	@service_history ||= ServiceHistory.find(params[:id])
  end
end
