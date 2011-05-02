class UserImage < ActiveRecord::Base
  belongs_to :user_profile
  validates_presence_of :name
  validates_attachment_presence :picture
  has_attached_file :picture,
    :styles => {
      :large => '100x100#',
      :badge => '30x30'
    },
    :default_style => :large
  attr_accessible :picture, :name, :is_profile_picture
end
