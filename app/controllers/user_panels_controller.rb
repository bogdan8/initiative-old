class UserPanelsController < ApplicationController
  load_and_authorize_resource class: Initiative

  def index
    @initiatives = Initiative.where('user_id = ?',
                                    current_user.id).page(params[:page]).per(3) unless current_user.has_role? :admin
    @last_page = @initiatives.last_page?
    @current_page = @initiatives.current_page
  end

  def show_user
    @user = User.find(current_user.id)
  end
end
