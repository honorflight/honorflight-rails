class PeopleAttachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :person
end
