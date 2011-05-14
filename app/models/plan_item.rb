class PlanItem < ActiveRecord::Base
  belongs_to :plan
  has_many :metrics
  accepts_nested_attributes_for :metrics, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
