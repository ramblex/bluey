class CreateUserImages < ActiveRecord::Migration
  def self.up
    create_table :user_images do |t|
      t.string :name
      t.integer :user_profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_images
  end
end
