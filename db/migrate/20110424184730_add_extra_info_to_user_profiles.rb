class AddExtraInfoToUserProfiles < ActiveRecord::Migration
  def self.up
    add_column :user_profiles, :gym, :string
    add_column :user_profiles, :sports, :text
    add_column :user_profiles, :brands, :text
    add_column :user_profiles, :dob, :date
  end

  def self.down
    remove_column :user_profiles, :dob
    remove_column :user_profiles, :brands
    remove_column :user_profiles, :sports
    remove_column :user_profiles, :gym
  end
end
