module API
  module V1
    class DayOfFlightController < SessionController

      # GET 
      def people
        dof = DayOfFlight.current
        if dof.present?
          render json: dof.to_json(methods: [:veterans, :volunteers])
        else
          render json: {}
        end
      end

    end
  end
end
