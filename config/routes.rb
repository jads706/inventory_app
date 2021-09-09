Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get 'sessions/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/product_types', to: 'product_types#index'
  get '/units', to: 'units#index'
  get '/returns', to: 'units#borrowed_list_return'
  get '/checkout', to: 'users#checkout'
  get '/request_checkout', to: 'units#request_checkout'
  get '/request_return', to: 'units#request_return'
  get '/borrowed_units', to: 'units#borrowed_units'
  #get '/edit', to: 'users#edit'
  #admin
  get '/create_user', to: 'users#create_user'
  get '/users', to: 'users#index'
  get '/verify_user', to: 'users#verify_user'
  get '/transactions', to: 'transactions#index'
  resources :users
  resources :transactions
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :product_types, only: [:create, :destroy]
  resources :units do
    member do
      patch :returnManually
      patch :checkout
      patch :returning
      patch :approve
      patch :reject
      patch :approveR
      patch :rejectR
    end
  end
end
