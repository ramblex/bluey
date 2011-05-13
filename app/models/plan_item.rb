class PlanItem < ActiveRecord::Base
  belongs_to :plan
  has_many :metrics
end
