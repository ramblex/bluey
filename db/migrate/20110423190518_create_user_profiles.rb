class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.string :name
      t.text :summary
      t.string :city
      t.string :country
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
