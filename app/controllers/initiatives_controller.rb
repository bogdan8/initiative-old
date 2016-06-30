class InitiativesController < ApplicationController
  load_and_authorize_resource
  layout :initiative_layout

  def index
  end

  def show
  end

  def new
  end

  def create
    @initiative = Initiative.new initiative_params
    if @initiative.save
      redirect_to @initiative
      flash[:success] = 'Ініціативу додано'
    else
      render :new
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @initiative.update initiative_params
      redirect_to @initiative
      flash[:success] = 'Ініціативу відредаговано'
    else
      render :edit
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @initiative.destroy
      redirect_to @initiative
      flash[:success] = 'Ініціативу видалено'
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  private

  def initiative_params
    one_params = [:long_description, :sum, :term_fundraiser, :term_report, :main_picture]
    all_params = [:title, :main_video, :short_description, *one_params]
    params.require(:initiative).permit(*all_params)
  end

  def initiative_layout
    if current_user.has_role? :admin
      'admins'
    else
      'application'
    end
  end
end
