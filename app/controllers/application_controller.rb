class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :take_all_initiatives_to_show_in_the_admin_panel

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to main_app.root_url
  end
  layout :layout

  private

  def layout
    if current_user.nil?
      'application'
    elsif current_user.has_role? :admin
      'admins'
    else
      'application'
    end
  end

  def respond_to_format
    respond_to do |format|
      format.html
      format.js
    end
  end

  def take_all_initiatives_to_show_in_the_admin_panel
    @initiatives_pending_approval = Initiative.pending_approval unless Initiative.pending_approval.nil?
  end
end
