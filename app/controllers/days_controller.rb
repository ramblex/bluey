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

  def destroy
    @day = Day.find(params[:id])
    @day.destroy

    redirect_to :back, :notice => "Delete day. #{undo_link}".html_safe
  end

  private

  def undo_link
    view_context.link_to("undo", revert_version_path(@day.versions.scoped.last), :method => :post)
  end
end
