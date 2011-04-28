class AddIsProfilePictureToUserImages < ActiveRecord::Migration
  def self.up
    add_column :user_images, :is_profile_picture, :boolean, :default => false
  end

  def self.down
    remove_column :user_images, :is_profile_picture
  end
end
