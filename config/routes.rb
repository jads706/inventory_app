Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :product_types, only: [:create, :destroy]
  resources :units do
    member do
      patch :checkout
    end
  end
end
