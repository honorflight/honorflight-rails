module API
  module V1
    class PeopleController < SessionController
      # POST /people
      # POST /people.json
      def create
        type = person_params.delete(:type) || "veteran"
        type.capitalize!

                  # "Veteran".constantize => Veteran.new(...)
        @person = type.constantize.new(person_params)

        if type == "Veteran"
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
        type = person_params.delete(:type) || "veteran"
        type.capitalize!

        @person = type.constantize.find(params[:id])
        if @person.update_attributes(person_params)
          render :json => @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end

      end

      private
      def person_params
        params.require(:person).permit(:first_name, :last_name, :name_suffix_id, :middle_name, :email, :phone, :cell_phone, :birth_date, :release_info, :war_id, :shirt_size_id, :type, :special_request, :learned_about, :why_volunteer, :previous_experience, address_attributes: [:street1, :city, :state, :zipcode])
      end
    end
  end
end
