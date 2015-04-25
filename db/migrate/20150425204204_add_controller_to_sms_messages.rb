class AddControllerToSmsMessages < ActiveRecord::Migration
  def change
    add_column :sms_messages, :controller, :string
    add_column :sms_messages, :action, :string
    add_column :sms_messages, :error_code, :string
  end
end
