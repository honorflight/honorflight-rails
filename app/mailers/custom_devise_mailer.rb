class CustomDeviseMailer < Devise::Mailer  
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  before_action :configure_smtp_settings

  private
  def settings
    # binding.pry_remote
    @settings ||= SmtpSetting.first
  end

  def configure_smtp_settings
    ActionMailer::Base.default_url_options = { host: settings.host }
    ActionMailer::Base.default :from => "#{settings.from_name} <#{settings.username}>"
    ActionMailer::Base.smtp_settings = {
      address: settings.smtp_server,
      port: settings.port,
      domain: settings.host,
      authentication: settings.authentication, 
      user_name: settings.username,
      password: settings.password,
      enable_starttls_auto: settings.enable_starttls_auto,
      openssl_verify_mode: settings.openssl_verify_mode
    }
  end

end