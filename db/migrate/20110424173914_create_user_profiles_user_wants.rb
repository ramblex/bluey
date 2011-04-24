class CreateUserProfilesUserWants < ActiveRecord::Migration
  def self.up
    create_table :user_profiles_user_wants, :id => false do |t|
      t.integer :user_profile_id
      t.integer :user_want_id
    end
  end

  def self.down
  end
end
