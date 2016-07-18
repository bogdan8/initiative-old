class HomeController < ApplicationController
  def index
    session[:number] = 3
    @initiatives = Initiative.fundraiser.order(created_at: :desc).limit(session[:number])
  end

  def more_initiatives
    session[:number] += 3
    @initiatives = Initiative.fundraiser.order(created_at: :desc).limit(session[:number])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
