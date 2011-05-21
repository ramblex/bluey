class PlanItem < ActiveRecord::Base
  belongs_to :day
  has_many :plan_item_sets
  accepts_nested_attributes_for :plan_item_sets, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
