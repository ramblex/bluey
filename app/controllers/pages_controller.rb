class PagesController < ApplicationController
  def landing
    if current_user
      redirect_to plans_path
    end
  end
end
