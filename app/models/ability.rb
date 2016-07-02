class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      the_administrator_can_do
    else
      the_user_can_do user
    end
  end

  def the_administrator_can_do
    can :manage, User
    can :manage, Initiative
    can :manage, Category
  end

  def the_user_can_do(user)
    can :read, :all
    cannot :read, User
    can [:show, :update], User, id: user.id
    can :manage, Initiative, id: user.id
    cannot :manage, Category
    can [:show], Category
  end
end
