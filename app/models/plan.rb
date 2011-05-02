class Plan < ActiveRecord::Base
  validates_presence_of :name
  attr_accessible :name, :description
  has_many :plan_days
  accepts_nested_attributes_for :plan_days, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
