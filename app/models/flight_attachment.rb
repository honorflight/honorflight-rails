class FlightAttachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :day_of_flight
end
