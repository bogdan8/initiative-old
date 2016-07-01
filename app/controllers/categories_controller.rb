class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
  end

  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to '/categories'
      flash[:success] = 'Категорію додано'
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
      flash[:success] = 'Дані успішно відредаговані'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to '/categories'
      flash[:success] = 'Категорію видалено'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
