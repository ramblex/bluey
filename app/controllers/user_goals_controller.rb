class UserGoalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_goals = current_user.user_profile.user_goals
  end

  def update
    @user_goals = current_user.user_profile.user_goals
    @errors = false
    @user_goals.each do |user_goal|
      goals = params[:user_goals][user_goal.id.to_s]
      if !goals.nil? && !user_goal.update_attributes(params[:user_goals][user_goal.id.to_s])
        @errors = true
      end
    end
    respond_to do |format|
      if @errors
        format.js
        format.html { redirect_to user_goals_path, :notice => 'Updated your goals' }
      else
        format.js
        format.html { render :action => 'index', :alert => 'Could not update your stats' }
      end
    end
  end
end
