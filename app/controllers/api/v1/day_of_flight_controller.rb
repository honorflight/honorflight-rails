module API
  module V1
    class DayOfFlightController < SessionController

      # GET 
      def people
        dof = DayOfFlight.next_flight
        if dof.present?
          render json: dof.as_json(
            only: [:id, :flies_on],
            include: {
              veterans: {
                only: [:id, :first_name, :last_name],
                include: {
                  guardian: {
                    only: [:id, :first_name, :last_name, :cell_phone]
                  }
                }
              },
              volunteers: {
                only: [:id, :first_name, :last_name, :cell_phone]
              }
            }
          )
        else
          render json: {}
        end
      end

    end
  end
end
