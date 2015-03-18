class ApplicationMailer < ActionMailer::Base
  default from: SmtpSetting.first.from_name

  private
  def settings
    @settings ||= SmtpSetting.first
  end

  def configure_smtp_settings
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
