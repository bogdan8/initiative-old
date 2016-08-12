Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  resources :admins do
    get :payments, on: :collection
  end
  resources :initiatives do
    get :all, on: :collection
    get :pending_approval, on: :collection
    get :fundraising_finished, on: :collection
    get :report, on: :collection
    get :audit_implemented, on: :collection
    get :for_confirmation, on: :member
    get :success_confirmation, on: :member
    get :error_confirmation, on: :member
    get :started_implement, on: :member
    get :insufficient_funds, on: :member
    get :implemented, on: :member
    get :unrealized, on: :member
    get :locked, on: :member
    post 'edit/delete_images', to: 'initiatives#delete_images', on: :member
    resources :timeline, only: [:create]
  end
  resources :categories
  get 'search', to: 'search#index'
  get 'search/sort', to: 'search#sort'

  get 'user_panels', to: 'user_panels#index'
  get 'user_panels_information', to: 'user_panels#show_user'
  get 'user_panels_initiative/:id', to: 'user_panels#show_initiative'
  get 'my_payments', to: 'user_panels#my_payments'

  get 'reports', to: 'home#reports'

  # payed callback
  get 'donations/stripe', to: 'donations#stripe'
  post 'donations/:id/paypal', to: 'donations#paypal'
  post '/hook', to: 'donations#hook'
  post '/initiatives/:id', to: 'initiatives#show'
end
