class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      the_administrator_can_do user
    elsif user.has_role? :user
      the_user_can_do user
    else
      the_not_authorized_user_can
    end
  end

  private

  def the_administrator_can_do(user)
    can :manage, [User, Initiative, Category]
    cannot :destroy, User, id: user.id
  end

  def the_user_can_do(user)
    cannot :manage, [User, Initiative, Category]
    can [:show, :update], User, id: user.id
    can :read, Initiative
    can :manage, Initiative, user_id: user.id
    can :read, Category
    cannot [:pending_approval], Initiative
    cannot [:show_user], Initiative, user_id: user.id
  end

  def the_not_authorized_user_can
    cannot :manage, [User, Initiative, Category]
    can :read, Initiative
  end
end
