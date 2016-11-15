class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.order(:position)
  end

  def show
  end

  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to '/categories'
      flash[:success] = t('controller.catrgory.save')
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      redirect_to '/categories'
      flash[:success] = t('controller.catrgory.update')
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to '/categories'
      flash[:success] = t('controller.catrgory.destroy')
    else
      flash[:error] = @category.errors.full_messages.to_sentence
    end
  end

  def sort
    params[:category].each_with_index do |id, index|
      Category.find(id).update(position: index + 1)

    end
    render nothing: true
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
