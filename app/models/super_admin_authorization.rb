class SuperAdminAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    if action == :destroy
      user.can_delete?
    else
      true
    end
  end
end