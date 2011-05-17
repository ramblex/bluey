class DaysController < ApplicationController
  def create
    plan = Plan.find(params[:plan_id])
    next_day_number = (plan.days.empty?) ? 1 : plan.days.maximum("number") + 1
    @day = Day.new(:plan => plan, :number => next_day_number)
    respond_to do |format|
      if @day.save
        format.html { redirect_to :back, :notice => 'Added day to your plan' }
        format.js
      else
        format.html { redirect_to :back, :alert => 'Could not add a day' }
        format.js
      end
    end
  end
end
