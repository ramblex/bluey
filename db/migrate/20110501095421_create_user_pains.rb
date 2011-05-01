class CreateUserPains < ActiveRecord::Migration
  def self.up
    create_table :user_pains do |t|
      t.integer :user_profile_id
      t.integer :body_part_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_pains
  end
end
