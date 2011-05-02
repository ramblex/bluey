class AddDescAndTypeToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :description, :text
    add_column :plans, :type_id, :integer
  end

  def self.down
    remove_column :plans, :type_id
    remove_column :plans, :description
  end
end
