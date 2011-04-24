class CreateUserProfilesUserTypes < ActiveRecord::Migration
  def self.up
    create_table :user_profiles_user_types, :id => false do |t|
      t.integer :user_profile_id
      t.integer :user_type_id
    end
  end

  def self.down
    drop_table :user_profiles_user_types
  end
end
