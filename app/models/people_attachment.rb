class PeopleAttachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :person

  # t.integer  "person_id"
  #   t.string   "attachment"
  #   t.string   "name"
  #   t.string   "comments"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
end
