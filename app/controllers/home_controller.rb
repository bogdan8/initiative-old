class HomeController < ApplicationController
  def index
    @initiatives = Initiative.fundraiser.order(created_at: :desc).page(params[:page]).per(6)
  end
end
