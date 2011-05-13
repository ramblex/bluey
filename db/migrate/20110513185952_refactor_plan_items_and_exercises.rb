class RefactorPlanItemsAndExercises < ActiveRecord::Migration
  def self.up
    drop_table :exercises
    add_column :plan_items, :name, :string
    remove_column :plan_items, :exercise_id

    create_table :metrics do |t|
      t.string :amount, :default => "0"
      t.string :unit
      t.integer :plan_item_id
    end
  end

  def self.down
    drop_table :metrics
    remove_column :plan_items, :name
    add_column :plan_items, :exercise_id, :integer
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
