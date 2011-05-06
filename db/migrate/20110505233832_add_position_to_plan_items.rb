class AddPositionToPlanItems < ActiveRecord::Migration
  def self.up
    add_column :plan_items, :position, :integer
  end

  def self.down
    remove_column :plan_items, :position
  end
end
