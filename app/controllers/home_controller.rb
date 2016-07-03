class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @initiatives = Initiative.order(created_at: :desc)
  end
end
