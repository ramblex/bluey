class UserStatsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_stats = current_user.user_profile.user_stats
  end

  def update
    @user_stats = current_user.user_profile.user_stats
    @errors = false
    @user_stats.each do |user_stat|
      logger.info "Stats: #{params[:user_stats][user_stat.id.to_s].inspect}"
      if !user_stat.update_attributes(params[:user_stats][user_stat.id.to_s])
        @errors = true
      end
    end
    respond_to do |format|
      if @errors
        format.js
        format.html { redirect_to user_stats_path, :notice => 'Updated your stats' }
      else
        format.js
        format.html { render :action => 'index', :alert => 'Could not update your stats' }
      end
    end
  end
end
