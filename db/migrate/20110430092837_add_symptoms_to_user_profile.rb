class AddSymptomsToUserProfile < ActiveRecord::Migration
  def self.up
    add_column :user_profiles, :symptoms, :text
  end

  def self.down
    remove_column :user_profiles, :symptoms
  end
end
