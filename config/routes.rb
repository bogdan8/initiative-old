Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'

  resources :admins
  resources :initiatives do
    get :pending_approval, on: :collection
    get :fundraising_finished, on: :collection
    get :for_confirmation, on: :member
    get :success_confirmation, on: :member
    get :error_confirmation, on: :member
    get :started_implement, on: :member
    post 'edit/delete_images', to: 'initiatives#delete_images', on: :member
    resources :timeline, only: [:create]
  end
  resources :categories
  get 'search', to: 'search#index'
  get 'search/sort', to: 'search#sort'

  get 'user_panels', to: 'user_panels#index'
  get 'user_panels_information', to: 'user_panels#show_user'
  get 'user_panels_initiative/:id', to: 'user_panels#show_initiative'

end
