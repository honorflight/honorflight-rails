module API
  module V1
    class PeopleController < SessionController
      # POST /people
      # POST /people.json
      def create
        @person = Person.new(person_params)

        if person_params[:type].blank? 
          @person.type = "Veteran"
        end 
        
        @person.type.capitalize!


        if @person.type == "Veteran"
          @person.veteran = true
        end


        @person.applied_online = true
        if @person.save
          render :json => @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # # PATCH/PUT /people/1
      # # PATCH/PUT /people/1.json
      def update
        @person = Person.find(params[:id])
        if @person.update_attributes(person_params)
          render :json => @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end

      end

      private
      def person_params
        params.require(:person).permit(:first_name, :last_name, :middle_name, :email, :phone, :birth_date, :release_info, :war_id, :shirt_size_id, :type, address_attributes: [:street1, :city, :state, :zipcode])
      end
    end
  end
end
