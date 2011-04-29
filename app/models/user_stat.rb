class UserStat < ActiveRecord::Base
  belongs_to :body_part
  belongs_to :user_profile

  validates :current_value,
    :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
    :numericality => {:greater_than => 0},
    :allow_nil => true
  validates :goal_value,
    :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
    :numericality => {:greater_than => 0},
    :allow_nil => true
end
