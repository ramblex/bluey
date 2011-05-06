class AddAttachmentPictureToExercise < ActiveRecord::Migration
  def self.up
    add_column :exercises, :picture_file_name, :string
    add_column :exercises, :picture_content_type, :string
    add_column :exercises, :picture_file_size, :integer
    add_column :exercises, :picture_updated_at, :datetime
  end

  def self.down
    remove_column :exercises, :picture_file_name
    remove_column :exercises, :picture_content_type
    remove_column :exercises, :picture_file_size
    remove_column :exercises, :picture_updated_at
  end
end
