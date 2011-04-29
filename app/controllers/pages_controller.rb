class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:landing]

  def landing
    if current_user
      flash.keep
      redirect_to pages_dashboard_path
    end
  end

  def dashboard
  end
end
