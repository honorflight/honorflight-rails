class CreateSmtpSettings < ActiveRecord::Migration
  def change
    create_table :smtp_settings do |t|
      t.boolean :send_mail
      t.string :host
      t.string :smtp_server
      t.integer :port
      t.string :authentication
      t.string :username
      t.string :password
      t.boolean :enable_starttls_auto
      t.string :openssl_verify_mode
      t.string :from_name
      t.string :default_url_options

      t.timestamps null: false
    end

    SmtpSetting.create(username: "admin@example.com")
  end
end
