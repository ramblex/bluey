class Day < ActiveRecord::Base
  belongs_to :plan
  has_many :plan_items
end
