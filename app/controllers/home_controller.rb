class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @initiatives = Initiative.fundraiser.order(created_at: :desc).page(params[:page]).per(2)
  end
end
