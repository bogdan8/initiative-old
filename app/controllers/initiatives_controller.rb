class InitiativesController < ApplicationController
  load_and_authorize_resource
  before_action :all_category, only: [:new, :edit]
  before_action :find_initiatives, only: [:delete_images, :error_confirmation, :success_confirmation, :for_confirmation]

  include AbilityStateToInitiatives

  def index
  end

  def show
  end

  def new
  end

  def create
    @initiative = Initiative.new initiative_params
    add_initiative_with_categories
    if @initiative.save
      add_images_to_initiative
      redirect_to @initiative
      flash[:success] = t('controller.initiative.save')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    InitiativeCategory.delete_all("initiative_id = #{@initiative.id}")
    add_initiative_with_categories
    if @initiative.update initiative_params
      redirect_to @initiative
      flash[:success] = t('controller.initiative.update')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @initiative.destroy
      redirect_to @initiative
      flash[:success] = t('controller.initiative.destroy')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def pending_approval
    @initiative_approval = Initiative.all.pending_approval
  end

  def delete_images
    @images = @initiative.initiative_images.find(params[:initiative_photo_id])
    if @images.destroy
      redirect_to "/initiatives/#{@initiative.id}/edit"
      flash[:success] = t('controller.initiative.success_delete_photos_in_initiative')
    else
      flash[:error] = @images.errors.full_messages.to_sentence
    end
  end

  private

  def all_category
    @all_categories = Category.all
    @initiative_category = @initiative.initiative_categories.build
  end

  def initiative_params
    one_params = [:long_description, :sum, :term_fundraiser, :term_report, :main_picture]
    all_params = [:title, :main_video, :short_description, :initiative_images, *one_params]
    params.require(:initiative).permit(*all_params).merge(user_id: current_user.id)
  end

  def find_initiatives
    @initiative = Initiative.find(params[:id])
  end

  def add_initiative_with_categories
    unless params[:category].nil?
      params[:category][:id].each do |category|
        @initiative.initiative_categories.build(category_id: category) unless category.empty?
      end
    end
  end

  def add_images_to_initiative
    if params[:initiative_images]
      params[:initiative_images].each do |image|
        @initiative.initiative_images.create(initiative_images: image)
      end
    end
  end
end
