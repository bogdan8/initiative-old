require 'rails_helper'

describe TimelineController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.confirm
    sign_in @user
    create(:initiative, user_id: @user.id)
  end
  describe '#GET ' do
    it '#redirects to the home page upon save' do
    end
  end
end
