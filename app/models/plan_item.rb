class PlanItem < ActiveRecord::Base
  has_and_belongs_to_many :plan_days
end
