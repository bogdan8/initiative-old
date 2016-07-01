class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, User
      can :manage, Initiative
      can :manage, Category
    else
      can :read, :all
      cannot :read, User
      can [:show, :update], User, id: user.id
      can :manage, Initiative, id: user.id
    end
  end
end
