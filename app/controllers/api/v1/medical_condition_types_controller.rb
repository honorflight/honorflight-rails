class API::V1::MedicalConditionTypesController < ApplicationController
  def index
    @medical_condition_types = MedicalConditionType.all()

    render :json => @medical_condition_types.to_json(include: :medical_condition_names) 
  end
end
