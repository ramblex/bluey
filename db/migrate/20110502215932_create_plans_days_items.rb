class CreatePlansDaysItems < ActiveRecord::Migration
  def self.up
    create_table :plan_days_plan_items, :id => false do |t|
      t.integer :plan_day_id
      t.integer :plan_item_id
    end
  end

  def self.down
  end
end
