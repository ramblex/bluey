class AddPlanItemIdToMetrics < ActiveRecord::Migration
  def self.up
    add_column :metrics, :plan_item_id, :integer
  end

  def self.down
    remove_column :metrics, :plan_item_id
  end
end
