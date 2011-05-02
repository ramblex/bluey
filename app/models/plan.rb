class Plan < ActiveRecord::Base
  validates_presence_of :name
  attr_accessible :name, :description
end
