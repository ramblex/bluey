class AddCachedSlugToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :cached_slug, :string
  end

  def self.down
    remove_column :plans, :cached_slug
  end
end
