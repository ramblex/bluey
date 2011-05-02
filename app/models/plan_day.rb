class PlanDay < ActiveRecord::Base
  belongs_to :plan
  has_and_belongs_to_many :plan_item
end
