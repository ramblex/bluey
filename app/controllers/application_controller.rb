class ApplicationController < ActionController::Base
  protect_from_forgery

  def default_path
    if current_user.user_profile.name.nil?
      edit_user_profiles_path
    else
      pages_dashboard_path
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(:user) || default_path
  end
end
