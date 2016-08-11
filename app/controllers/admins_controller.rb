class AdminsController < ApplicationController
  load_and_authorize_resource class: User, except: [:create]

  def index
    @admins = User.with_role(:admin)
  end

  def show
  end

  def new
  end

  def create
    @admin = User.new user_params
    @admin.skip_confirmation!
    if @admin.save
      @admin.add_role 'admin'
      redirect_to '/admins'
      flash[:success] = t('controller.admins.save')
    else
      flash[:error] = @admin.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update user_params
      redirect_to '/admins'
      flash[:success] = t('controller.admins.update')
    else
      flash[:error] = @admin.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to '/admins'
      flash[:success] = t('controller.admins.destroy')
    else
      flash[:error] = @admin.errors.full_messages.to_sentence
    end
  end

  def payments
    @donate = Donation.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :post, :phone, :avatar, :email, :password)
  end
end
