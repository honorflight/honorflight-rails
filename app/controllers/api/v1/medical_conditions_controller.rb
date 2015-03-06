class API::V1::MedicalConditionsController < SessionController
	before_filter :set_person, only: [:create]
	before_filter :set_medical_condition, only: [:update]

  # POST /people/:person_id/medical_conditions
  # POST /people/:person_id/medical_conditions.json
  def create
  	@medical_condition =  MedicalCondition.create(medical_condition_params)
  	if @person.medical_conditions << @medical_condition
  		render :json => @medical_condition
    # No invalid routes right now
  	# else
  	# 	render json: @medical_condition.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /medical_conditions/1
  # # PATCH/PUT /medical_conditions/1.json
  def update
    if @medical_condition.update_attributes(medical_condition_params)
      render :json => @medical_condition
    # no invalid routes right now
    # else
    #   render json: @medical_condition.errors, status: :unprocessable_entity
    end

  end

  private
  def set_person
    @person = Person.find(params[:person_id])
  end

  def medical_condition_params
    params.require(:medical_condition).permit(:diagnosed_at, :diagnosed_last, :description, :medical_condition_type_id, :medical_condition_name_id)
      # :first_name, :last_name, :middle_name, :email, :phone, :birth_date, :war_id, :shirt_size_id, address_attributes: [:street1, :city, :state, :zipcode])
  end
  def set_medical_condition
  	@medical_condition ||= MedicalCondition.find(params[:id])
  end
end
