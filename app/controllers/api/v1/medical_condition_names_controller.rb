class API::V1::MedicalConditionNamesController < ApplicationController
  def index
    @medical_condition_names = MedicalConditionName.all()

    render json: @medical_condition_names
  end
end
