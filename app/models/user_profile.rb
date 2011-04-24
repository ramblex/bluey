class UserProfile < ActiveRecord::Base
  validates_presence_of :city, :country
  has_and_belongs_to_many :user_types
end
