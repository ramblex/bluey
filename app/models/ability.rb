class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Plan do |plan|
      plan && plan.creator.id == user.id
    end
  end
end
