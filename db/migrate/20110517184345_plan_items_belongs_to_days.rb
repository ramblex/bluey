class PlanItemsBelongsToDays < ActiveRecord::Migration
  def self.up
    rename_column :plan_items, :plan_id, :day_id
    remove_column :plan_items, :day
  end

  def self.down
    rename_column :plan_items, :day_id, :plan_id
    add_column :plan_items, :day, :integer
  end
end
