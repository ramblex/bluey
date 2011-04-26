class User < ActiveRecord::Base
  has_one :user_profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create :create_profile

private
  def create_profile
    user_profile = UserProfile.new(:user_id => self.id)
    user_profile.save(:validate => false)
  end
end
