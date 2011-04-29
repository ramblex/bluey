class UserStatsController < ApplicationController
  def index
    @user_stats = current_user.user_profile.user_stats
  end
end
