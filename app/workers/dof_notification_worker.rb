class DofNotificationWorker
  include Sidekiq::Worker

  def perform(day_of_flight_id)
    flight = DayOfFlight.where({id: day_of_flight_id, notification_key: jid}).first
    if flight.present?
      # Set notifications for Guardians and Volunteers on flight
      flight.build_welcome_for_volunteer
      flight.build_welcome_for_guardian
    end
  end
end