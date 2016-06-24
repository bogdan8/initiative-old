class AdminsController < ApplicationController
  load_and_authorize_resource class: User

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  def index
    @admins = User.with_role(:admin)
  end

  def show
  end

  def new
  end

  def create
    @admin = User.new user_params
    @admin.add_role 'admin'
    if @admin.save
      redirect_to '/admins'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @admin.update user_params
      redirect_to '/admins'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @admin.destroy
      redirect_to '/admins'
    else
      render action: 'destroy'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
