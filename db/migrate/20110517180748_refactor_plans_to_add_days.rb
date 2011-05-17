class RefactorPlansToAddDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.string :name
      t.integer :number
      t.integer :plan_id
      t.timestamps
    end

    add_column :metrics, :set, :integer
    rename_table :plan_items, :exercises
  end

  def self.down
    drop_table :days
    remove_column :metrics, :set
    rename_table :exercises, :plan_items
  end
end
