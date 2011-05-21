class PlanItem < ActiveRecord::Base
  belongs_to :day
  has_many :sets
  accepts_nested_attributes_for :sets, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
