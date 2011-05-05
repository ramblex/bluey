class Exercise < ActiveRecord::Base
  belongs_to :plan_item
  attr_accessible :day, :plan_item_id
end
