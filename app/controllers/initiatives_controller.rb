class InitiativesController < ApplicationController
  def index
    @initiatives = Initiative.all
  end

  def show
    @initiative = Initiative.find(params[:id])
  end

  def new
  end

  def create
    @initiative = Initiative.new initiative_params
    if @initiative.save
      redirect_to @initiative
    else
      render action: 'new'
    end
  end

  def edit
    @initiative = Initiative.find(params[:id])
  end

  def update
    @initiative = Initiative.find(params[:id])
    if @initiative.update initiative_params
      redirect_to @initiative
    else
      render action: 'edit'
    end
  end

  def destroy
    @initiative = Initiative.find(params[:id])
    if @initiative.destroy
      redirect_to @initiative
    else
      render action: 'destroy'
    end
  end

  private

  def initiative_params
    params.require(:initiative).permit(:title, :main_video, :short_description, :long_description, :sum, :term_fundraiser, :term_report)
  end
end
