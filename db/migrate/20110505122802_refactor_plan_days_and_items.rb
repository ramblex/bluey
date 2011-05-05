class RefactorPlanDaysAndItems < ActiveRecord::Migration
  def self.up
    drop_table :plan_days
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    rename_column :plan_items, :plan_day, :day
    remove_column :plan_items, :description
    remove_column :plan_items, :name
    add_column :plan_items, :exercise_id, :integer
    add_column :plan_items, :plan_id, :integer
  end

  def self.down
    drop_table :exercises
    create_table :plan_days do |t|
      t.integer :day
      t.integer :plan_id

      t.timestamps
    end
  end
end
