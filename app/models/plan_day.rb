class PlanDay < ActiveRecord::Base
  belongs_to :plan
  has_and_belongs_to_many :plan_items
  accepts_nested_attributes_for :plan_items, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
