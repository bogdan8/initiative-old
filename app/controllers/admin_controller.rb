class AdminController < ApplicationController
  load_and_authorize_resource class: User

  def index
  end

  def show
  end

  def new
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

  def edit
  end

  def update
    if @admin.update(user_params)
      redirect_to '/admin'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @admin.destroy
      redirect_to '/admin'
    else
      render action: 'destroy'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
