module DefaultUrlOptions
  def default_url_options
    {
      :host => host,
      :port => port
    }
  end

private
  def settings
    @settings ||= SmtpSetting.first
  end

  def host
    settings.host
  end

  def port
    settings.port
  end
end