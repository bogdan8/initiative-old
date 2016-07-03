class InitiativesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @initiative = Initiative.new initiative_params
    if @initiative.save
      add_initiative_with_categories
      redirect_to @initiative
      flash[:success] = 'Ініціативу додано'
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @initiative.update initiative_params
      redirect_to @initiative
      flash[:success] = 'Ініціативу відредаговано'
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
      render :edit
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

  def add_initiative_with_categories
    unless params[:category_ids].nil?
      params[:category_ids].each do |id|
        InitiativeCategory.create(initiative_id: @initiative.id, category_id: id)
      end
    end
  end
end
