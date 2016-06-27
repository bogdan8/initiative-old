class InitiativesController < ApplicationController
  load_and_authorize_resource class: Initiative, except: [:create]
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
      render action: 'new'
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
      render action: 'edit'
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @initiative.destroy
      redirect_to @initiative
      flash[:success] = 'Ініціативу видалено'
    else
      render action: 'destroy'
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  private

  def initiative_params
    arr = [:title, :main_video, :short_description, :long_description, :sum, :term_fundraiser, :term_report, :main_picture]
    params.require(:initiative).permit(*arr)
  end

  def initiative_layout
    if current_user.has_role? :admin
      'admins'
    else
      'application'
    end
  end
end
