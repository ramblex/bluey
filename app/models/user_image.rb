class UserImage < ActiveRecord::Base
  validates_presence_of :name
  validates_attachment_presence :picture
  has_attached_file :picture,
    :styles => {
      :large => '100x100',
      :badge => '30x30'
    },
    :default_style => :large
end
