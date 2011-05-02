class UserPain < ActiveRecord::Base
  belongs_to :user_profile
  belongs_to :body_part

  attr_accessible :body_part_id
end
