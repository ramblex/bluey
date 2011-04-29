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

    ['Left Arm', 'Right Arm'].each do |arm|
      user_profile.user_goals.create!(:name => 'Bicep',
                                      :body_part => BodyPart.find_by_name(arm),
                                      :unit => 'inches')
      user_profile.user_goals.create!(:name => 'Tricep',
                                      :body_part => BodyPart.find_by_name(arm),
                                      :unit => 'inches')
      user_profile.user_goals.create!(:name => 'Forearm',
                                      :body_part => BodyPart.find_by_name(arm),
                                      :unit => 'inches')
    end
    ['Left Leg', 'Right Leg'].each do |leg|
      user_profile.user_goals.create!(:name => 'Upper leg',
                                      :body_part => BodyPart.find_by_name(leg),
                                      :unit => 'inches')
      user_profile.user_goals.create!(:name => 'Lower leg',
                                      :body_part => BodyPart.find_by_name(leg),
                                      :unit => 'inches')
    end
    user_profile.user_goals.create!(:name => 'Chest',
                                    :body_part => BodyPart.find_by_name('Chest'),
                                    :unit => 'inches')
    user_profile.user_goals.create!(:name => 'Waist',
                                    :body_part => BodyPart.find_by_name('Waist'),
                                    :unit => 'inches')
  end
end
