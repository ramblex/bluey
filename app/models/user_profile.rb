class UserProfile < ActiveRecord::Base
  has_and_belongs_to_many :user_types
  has_and_belongs_to_many :user_wants
  has_many :user_images
  has_many :user_stats
  accepts_nested_attributes_for :user_images, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?}}
end
