class CreatePlanDays < ActiveRecord::Migration
  def self.up
    create_table :plan_days do |t|
      t.integer :day
      t.integer :plan_id

      t.timestamps
    end
  end

  def self.down
    drop_table :plan_days
  end
end
