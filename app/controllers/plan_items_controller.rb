class PlanItemsController < ApplicationController
  def new
    @plan = Plan.find(params[:plan_id])
    @day = Day.find(params[:day_id])
    @plan_item = PlanItem.new
    @plan_item.plan_item_sets.build
  end

  def create
    @plan_item = PlanItem.new(params[:plan_item])
    @plan_item.day_id = params[:day_id]
    respond_to do |format|
      if @plan_item.save
        format.js
      else
        format.js
      end
    end
  end

  # PUT /update/:id
  def update
    @plan_item = PlanItem.find(params[:id])
    if @plan_item.update_attributes(params[:plan_item])
      render :text => "Updated plan item"
    end
  end
end
