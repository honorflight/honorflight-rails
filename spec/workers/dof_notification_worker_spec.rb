require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe DofNotificationWorker do
  it "should schedule a job" do
    expect {
      DofNotificationWorker.perform_async(1)
    }.to change(DofNotificationWorker.jobs, :size).by(1)
  end

  it "should perform" do
     f = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
     expect_any_instance_of(DayOfFlight).to receive(:build_welcome_for_volunteer)
     expect_any_instance_of(DayOfFlight).to receive(:build_welcome_for_guardian)
     DofNotificationWorker.drain
  end

  it "should not perform" do
     f = FactoryGirl.create(:day_of_flight, flies_on: Date.today)
     f.update_column(:notification_key, "") # key has changed since this was scheduled
     expect_any_instance_of(DayOfFlight).not_to receive(:build_welcome_for_volunteer)
     expect_any_instance_of(DayOfFlight).not_to receive(:build_welcome_for_guardian)
     DofNotificationWorker.drain
  end
end
