class Plan < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  validates_presence_of :name
  attr_accessible :name, :description, :plan_items_attributes
  has_many :plan_items
  accepts_nested_attributes_for :plan_items, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
