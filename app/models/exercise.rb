class Exercise < ActiveRecord::Base
  has_attached_file :picture,
    :styles => {
      :large => '120x120#',
      :badge => '30x30'
    },
    :default_style => :large
  attr_accessible :name, :description, :picture
end
