class RenameExercisesTable < ActiveRecord::Migration
  def self.up
    rename_table :exercises, :plan_items
  end

  def self.down
    rename_table :plan_items, :exercises
  end
end
