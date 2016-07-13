class InitiativesController < ApplicationController
  load_and_authorize_resource
  before_action :all_category, only: [:new, :edit]

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

  def for_confirmation
    @initiative = Initiative.find(params[:id])
    if @initiative.submit_for_confirmation!
      redirect_to '/user_panels'
      flash[:success] = t('controller.initiative.for_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def pending_approval
    @initiative_approval = Initiative.all.pending_approval
  end

  def success_confirmation
    @initiative = Initiative.find(params[:id])
    if @initiative.success_confirmation!
      redirect_to '/initiatives/pending_approval'
      flash[:success] = t('controller.initiative.success_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def error_confirmation
    @initiative = Initiative.find(params[:id])
    if @initiative.error_confirmation!
      redirect_to '/initiatives/pending_approval'
      flash[:success] = t('controller.initiative.error_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  private

  def all_category
    @all_categories = Category.all
    @initiative_category = @initiative.initiative_categories.build
  end

  def initiative_params
    one_params = [:long_description, :sum, :term_fundraiser, :term_report, :main_picture]
    all_params = [:title, :main_video, :short_description, *one_params]
    params.require(:initiative).permit(*all_params).merge(user_id: current_user.id)
  end

  def add_initiative_with_categories
    params[:category][:id].each do |category|
      @initiative.initiative_categories.build(category_id: category) unless category.empty?
    end
  end
end
