class CreateUserWants < ActiveRecord::Migration
  def self.up
    create_table :user_wants do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :user_wants
  end
end
