class HomeController < ApplicationController
  def index
    @initiatives = Initiative.fundraiser.order(created_at: :desc).page(params[:page]).per(3)
    @last_page = @initiatives.last_page?
    @current_page = @initiatives.current_page
  end

  def more_initiatives
    @initiatives = Initiative.fundraiser.order(created_at: :desc).limit(session[:number])
    respond_to_format
  end
end
