Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'home#index'

  resources :admins
  resources :initiatives do
    get :pending_approval, on: :collection
    get :for_confirmation, on: :member
    get :success_confirmation, on: :member
    get :error_confirmation, on: :member
    post 'edit/delete_images', to: 'initiatives#delete_images', on: :member
  end
  resources :categories
  get 'search', to: 'search#index'
  get 'search/sort', to: 'search#sort'

  get 'user_panels', to: 'user_panels#index'
  get 'user_panels_information', to: 'user_panels#show_user'
end
