Rails.application.routes.draw do
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
  resources :users
  resources :product_types, only: [:create, :destroy]
  resources :units do
    member do
      patch :checkout
      patch :returning
      patch :approve
      patch :reject
    end
  end
end
