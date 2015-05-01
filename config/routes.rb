BreadExpress::Application.routes.draw do

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "items/show"
  get "items/edit"
  get "items/update"
  get "items/destroy"
  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items
  resources :item_prices
  resources :order_items
  resources :users
  resources :sessions

  
  # Authentication routes
  get 'signup' => 'users#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login



  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  
  # Set the root url
  root :to => 'home#home'
  
  # Named routes



  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
