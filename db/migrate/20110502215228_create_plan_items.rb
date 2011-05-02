class CreatePlanItems < ActiveRecord::Migration
  def self.up
    create_table :plan_items do |t|
      t.string :name
      t.text :description
      t.integer :plan_day

      t.timestamps
    end
  end

  def self.down
    drop_table :plan_items
  end
end
