class AdminController < ApplicationController
  before_action :authenticate_user!

  include FindUser

  def index
    unless @user.has_role? :admin
      render text: CanCan::AccessDenied.new('Ви не адміністратор!', :read, User)
    end
    @admin = User.all
  end

  def show
  end

  def new
    unless @user.has_role? :admin
      render text: CanCan::AccessDenied.new('Ви не адміністратор!', :read, User)
    end
  end

  def create
    @admin = User.new user_params
    @admin.add_role 'admin'
    if @admin.save
      redirect_to '/admin'
    else
      render action: 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
