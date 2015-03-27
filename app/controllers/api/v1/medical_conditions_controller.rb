class API::V1::MedicalConditionsController < SessionController
	before_filter :set_veteran, only: [:index, :create]
	before_filter :set_medical_condition, only: [:destroy]

  # GET /people/:person_id/medical_conditions
  def index
    render json: @veteran.medical_conditions
  end

  # POST /people/:person_id/medical_conditions
  # POST /people/:person_id/medical_conditions.json
  def create
  	@medical_condition =  MedicalCondition.create(medical_condition_params)
  	if @veteran.medical_conditions << @medical_condition
  		render :json => @medical_condition
    # No invalid routes right now
  	# else
  	# 	render json: @medical_condition.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @medical_condition.destroy
      render json: {id: params[:id], status: "Deleted"}
    end
  end

  private
  def set_veteran
    @veteran = Veteran.find(params[:person_id])
  end

  def medical_condition_params
    params.require(:medical_condition).permit(:diagnosed_at, :diagnosed_last, :description, :medical_condition_type_id, :medical_condition_name_id)
      # :first_name, :last_name, :middle_name, :email, :phone, :birth_date, :war_id, :shirt_size_id, address_attributes: [:street1, :city, :state, :zipcode])
  end
  def set_medical_condition
  	@medical_condition ||= MedicalCondition.find(params[:id])
  end
end
