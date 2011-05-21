class RefactorSetsAndMetrics < ActiveRecord::Migration
  def self.up
    create_table :sets do |t|
      t.string :measurements
      t.integer :plan_item_id
      t.timestamps
    end
    drop_table :metrics
  end

  def self.down
    drop_table :sets
  end
end
