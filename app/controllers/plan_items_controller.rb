class PlanItemsController < ApplicationController
  # PUT /update/:id
  def update
    @plan_item = PlanItem.find(params[:id])
    if @plan_item.update_attributes(params[:plan_item])
      render :text => "Updated plan item"
    end
  end
end
