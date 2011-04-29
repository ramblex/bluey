class CreateBodyParts < ActiveRecord::Migration
  def self.up
    create_table :body_parts do |t|
      t.string :name
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end

  def self.down
    drop_table :body_parts
  end
end
