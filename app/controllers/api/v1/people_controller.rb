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
        # respond_to do |format|
        #   if @picture.update(picture_params)
        #     format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        #     format.json { render :show, status: :ok, location: @picture }
        #   else
        #     format.html { render :edit }
        #     format.json { render json: @picture.errors, status: :unprocessable_entity }
        #   end
        # end
      end

      private
      def person_params
        params.require(:person).permit(:first_name, :last_name, :middle_name, :email, :phone, :birth_date)
      end
    end
  end
end