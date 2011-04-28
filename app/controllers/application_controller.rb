class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      default_path = edit_user_profiles_path
    else
      default_path = pages_dashboard_path
    end
    stored_location_for(:user) || default_path
  end
end
