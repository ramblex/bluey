class RenameSetsTable < ActiveRecord::Migration
  def self.up
    rename_table :sets, :plan_item_sets
  end

  def self.down
    rename_table :plan_item_sets, :sets
  end
end
