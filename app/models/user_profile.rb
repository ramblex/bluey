class UserProfile < ActiveRecord::Base
  validates_presence_of :city, :country
end
