class AdminsController < ApplicationController
  load_and_authorize_resource class: User, except: [:create]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to main_app.root_url
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
      flash[:success] = 'Адміністратора додано'
    else
      render action: 'new'
      flash[:error] = @admin.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @admin.update user_params
      redirect_to '/admins'
      flash[:success] = 'Дані успішно відредаговані'
    else
      render action: 'edit'
      flash[:error] = @admin.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @admin.destroy
      redirect_to '/admins'
      flash[:success] = 'Адміністратора видалено'
    else
      render action: 'destroy'
      flash[:error] = @admin.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :post, :phone, :avatar, :email, :password)
  end
end
