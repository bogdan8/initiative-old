class UserPanelsController < ApplicationController
  load_and_authorize_resource class: Initiative

  def index
    @initiatives = Initiative.where('user_id = ?', current_user.id) unless current_user.has_role? :admin
  end
end
