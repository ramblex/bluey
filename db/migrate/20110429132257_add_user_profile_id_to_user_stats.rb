class AddUserProfileIdToUserStats < ActiveRecord::Migration
  def self.up
    add_column :user_stats, :user_profile_id, :integer
  end

  def self.down
    remove_column :user_stats, :user_profile_id
  end
end
