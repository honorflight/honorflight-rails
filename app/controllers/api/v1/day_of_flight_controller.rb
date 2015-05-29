module API
  module V1
    class DayOfFlightController < SessionController

      # GET 
      def people
        dof = DayOfFlight.current
        if dof.present?
          render json: dof.as_json(
            only: [:id],
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
