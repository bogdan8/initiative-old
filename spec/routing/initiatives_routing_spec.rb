require 'rails_helper'

describe InitiativesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: initiatives_path).to route_to 'initiatives#index'
    end

    it 'routes to #new' do
      expect(get: new_initiative_path).to route_to 'initiatives#new'
    end

    it 'routes to #show' do
      expect(get: '/initiatives/1').to route_to 'initiatives#show', id: '1'
    end

    it 'routes to #edit' do
      expect(get: '/initiatives/1/edit').to route_to 'initiatives#edit', id: '1'
    end

    it 'routes to #create' do
      expect(post: initiatives_path).to route_to 'initiatives#create'
    end

    it 'routes to #update via PUT' do
      expect(put: '/initiatives/1').to route_to 'initiatives#update', id: '1'
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/initiatives/1').to route_to 'initiatives#update', id: '1'
    end

    it 'routes to #destroy' do
      expect(delete: '/initiatives/1').to route_to 'initiatives#destroy', id: '1'
    end

    it 'routes to #pending_approval' do
      expect(get: pending_approval_initiatives_path).to route_to 'initiatives#pending_approval'
    end

    it 'routes to #for_confirmation' do
      expect(get: '/initiatives/1/for_confirmation').to route_to 'initiatives#for_confirmation', id: '1'
    end

    it 'route to #success_confirmation' do
      expect(get: '/initiatives/1/success_confirmation').to route_to 'initiatives#success_confirmation', id: '1'
    end

    it 'route to #error_confirmation' do
      expect(get: '/initiatives/1/error_confirmation').to route_to 'initiatives#error_confirmation', id: '1'
    end

    it 'route to #delete_images' do
      expect(post: '/initiatives/1/edit/delete_images').to route_to 'initiatives#delete_images', id: '1'
    end
  end
end
