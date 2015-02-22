module API
  module V1
    class PeopleController < SessionController
      # POST /pictures
      # POST /pictures.json
      def create
        request_body = ActiveSupport::JSON.decode(request.body.read)
        @person = Person.new(request_body)
        if @person.save
          render :json => @person 
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # # PATCH/PUT /pictures/1
      # # PATCH/PUT /pictures/1.json
      def update
        request_body = ActiveSupport::JSON.decode(request.body.read)
        @person = Person.find(params[:id])
        if @person.update_attributes(request_body)
          render :json => @person 
        else
          render json: @person.errors, status: :unprocessable_entity
        end

      end

      private
      def person_params
        params.require(:person).permit(:first_name, :last_name, :middle_name, :email, :phone, :birth_date, :war_id, :shirt_size_id, address_attributes: [:street1, :city, :state, :zipcode])
      end
    end
  end
end