class AddBodyPartIdToUserStats < ActiveRecord::Migration
  def self.up
    add_column :user_stats, :body_part_id, :integer
  end

  def self.down
    remove_column :user_stats, :body_part_id
  end
end
