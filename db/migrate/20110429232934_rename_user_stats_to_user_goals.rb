class RenameUserStatsToUserGoals < ActiveRecord::Migration
  def self.up
    rename_table :user_stats, :user_goals
  end

  def self.down
    rename_table :user_goals, :user_stats
  end
end
