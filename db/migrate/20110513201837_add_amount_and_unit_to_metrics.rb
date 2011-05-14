class AddAmountAndUnitToMetrics < ActiveRecord::Migration
  def self.up
    add_column :metrics, :amount, :string
    add_column :metrics, :unit, :string
  end

  def self.down
    remove_column :metrics, :unit
    remove_column :metrics, :amount
  end
end
