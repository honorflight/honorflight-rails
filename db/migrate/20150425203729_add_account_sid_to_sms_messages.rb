class AddAccountSidToSmsMessages < ActiveRecord::Migration
  def change
    add_column :sms_messages, :account_sid, :string
    add_column :sms_messages, :error_url, :string
  end
end
