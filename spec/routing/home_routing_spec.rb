require 'rails_helper'

describe HomeController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: root_path).to route_to 'home#index'
    end
  end
end
