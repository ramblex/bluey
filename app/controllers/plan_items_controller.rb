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

  def edit
    @plan_item = PlanItem.find(params[:id])
    @plan = Plan.find(params[:plan_id])
    @day = Day.find(params[:day_id])
  end

  # PUT /update/:id
  def update
    @plan_item = PlanItem.find(params[:id])
    respond_to do |format|
      if @plan_item.update_attributes(params[:plan_item])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @plan_item = PlanItem.find(params[:id])
    @plan_item.destroy
    redirect_to :back, :notice => "Deleted exercise #{undo_link}".html_safe
  end

  private

  def undo_link
    view_context.link_to("undo", revert_version_path(@plan_item.versions.scoped.last), :method => :post)
  end
end
