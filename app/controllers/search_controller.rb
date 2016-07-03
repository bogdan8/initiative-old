class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @initiatives = Initiative.where('title LIKE ?', "%#{params[:search]}%").order(created_at: :desc)
  end
end
