require 'rails_helper'

describe UserPanelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: user_panels_path).to route_to 'user_panels#index'
    end

    it 'routes to #show_user' do
      expect(get: user_panels_information_path).to route_to 'user_panels#show_user'
    end
  end
end
