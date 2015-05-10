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
     worker = DofNotificationWorker.new
     worker.perform(f.id)
  end

  it "should not perform" do

  end
end
