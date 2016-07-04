class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @initiatives = Initiative.where(aasm_state: :fundraiser).order(created_at: :desc)
  end
end
