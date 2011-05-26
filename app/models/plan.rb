class Plan < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  validates_presence_of :name
  attr_accessible :name, :description, :plan_items_attributes
  has_many :days
  has_paper_trail
end
