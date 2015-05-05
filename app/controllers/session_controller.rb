class SessionController < ActionController::Base
  before_filter :authenticate_admin_user!

private
  # Needed for sessions controller and some admin functionality
  def authenticate_admin_user!
    logger.debug "Trying to authenticate through APIKEY #{headers['HTTP_X_ADMIN_APIKEY']}"
    if request.headers['HTTP_X_ADMIN_APIKEY'].present?
      redirect_to new_admin_user_session_path unless AdminUser.authenticate_by_apikey(request.headers['HTTP_X_ADMIN_APIKEY'])
    else
      super
    end
  end

end