class TimelineController < ApplicationController
  load_and_authorize_resource

  def create
    @initiative = Initiative.find(params[:initiative_id])
    @initiative.timelines.create(timeline_params)

    redirect_to initiative_path(@initiative)
  end

  private

  def timeline_params
    params.require(:timeline).permit(:title, :date, :description)
  end
end
