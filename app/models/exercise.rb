class Exercise < ActiveRecord::Base
  has_attached_file :picture,
    :styles => {
      :large => '100x100#',
      :badge => '30x30'
    },
    :default_style => :large
  attr_accessible :name, :description, :picture
end
