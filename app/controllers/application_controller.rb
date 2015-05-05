class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_headers


  private
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

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
