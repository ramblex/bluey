class PagesController < ApplicationController
  def landing
    if current_user
      flash.keep
      redirect_to pages_dashboard_path
    end
  end

  def dashboard
  end
end
