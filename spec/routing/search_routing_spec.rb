require 'rails_helper'

describe SearchController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: search_path).to route_to 'search#index'
    end

    it 'routes to #sort' do
      expect(get: search_sort_path).to route_to 'search#sort'
    end
  end
end
