class User < ActiveRecord::Base
  has_one :user_profile
  has_many :plans, :foreign_key => 'creator_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create :create_profile

private
  def create_profile
    self.user_profile = UserProfile.new
    self.user_profile.save(:validate => false)

    general = BodyPart.find_by_name('General')
    goals = []
    ['Left Arm', 'Right Arm'].each do |arm|
      goals += [
        {:name => 'Bicep', :body_part => BodyPart.find_by_name(arm), :unit => 'inches'},
        {:name => 'Tricep', :body_part => BodyPart.find_by_name(arm), :unit => 'inches'},
        {:name => 'Forearm', :body_part => BodyPart.find_by_name(arm), :unit => 'inches'}
      ]
    end
    ['Left Leg', 'Right Leg'].each do |leg|
      goals += [
        {:name => 'Upper leg', :body_part => BodyPart.find_by_name(leg), :unit => 'inches'},
        {:name => 'Lower leg', :body_part => BodyPart.find_by_name(leg), :unit => 'inches'}
      ]
    end
    goals += [
      {:name => 'Chest', :body_part => BodyPart.find_by_name('Chest'), :unit => 'inches'},
      {:name => 'Waist', :body_part => BodyPart.find_by_name('Waist'), :unit => 'inches'},
      {:name => 'Weight', :body_part => general, :unit => 'lbs'},
      {:name => 'Blood pressure', :body_part => general, :unit => 'mmHg'},
      {:name => 'Heart rate', :body_part => general, :unit => 'bpm'},
      {:name => 'Body fat', :body_part => general, :unit => '%'}
    ]

    # Everything we want to set in user goals is protected. Therefore, need to
    # avoid using mass-assignment.
    goals.each do |g|
      new_goal = UserGoal.new
      new_goal.name = g[:name]
      new_goal.body_part = g[:body_part]
      new_goal.unit = g[:unit]
      new_goal.user_profile_id = self.id
      new_goal.save!
    end
  end
end
