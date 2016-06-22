# FindUser
module FindUser
  extend ActiveSupport::Concern

  included do
    before_action :user
  end

  def user
    @user = User.find(current_user.id)
  end
end
