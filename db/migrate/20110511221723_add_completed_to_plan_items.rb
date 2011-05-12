class AddCompletedToPlanItems < ActiveRecord::Migration
  def self.up
    add_column :plan_items, :completed, :boolean, :default => false
  end

  def self.down
    remove_column :plan_items, :completed
  end
end
