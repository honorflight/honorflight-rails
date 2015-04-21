class AddAttachmentToFlightAttachments < ActiveRecord::Migration
  def change
    add_column :flight_attachments, :attachment, :string
  end
end
