class CreateUserStats < ActiveRecord::Migration
  def self.up
    create_table :user_stats do |t|
      t.string :name
      t.decimal :current_value, :precision => 16, :scale => 2
      t.decimal :goal_value, :precision => 16, :scale => 2
      t.string :unit
      t.boolean :is_goal, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_stats
  end
end
