Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'home#index'

  resources :admins
  resources :initiatives
  resources :categories
  get 'search', to: 'search#index'
  get 'search/sort', to: 'search#sort'

  get 'user_panels', to: 'user_panels#index'
end
