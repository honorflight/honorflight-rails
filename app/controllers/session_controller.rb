class SessionController < ActionController::Base
  before_filter :authenticate_admin_user!

private
  def authenticate_admin_user!
    redirect_to new_admin_user_session_path unless AdminUser.authenticate_by_apikey(request.headers['HTTP_X_ADMIN_APIKEY'])
  end
end