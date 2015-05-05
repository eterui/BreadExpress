BreadExpress::Application.routes.draw do

  get "item_prices/show"
  get "item_prices/edit"
  get "item_prices/update"
  get "item_prices/destroy"
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
  get 'signup' => 'customers#new', as: :signup
  get 'register' => 'users#new', as: :register
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login



  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  get 'add_item/:id' => 'orders#add_item', as: :add_item
  get 'remove_item/:id' => 'orders#remove_item', as: :remove_item
  get 'drop_cart' => 'orders#drop_cart', as: :drop_cart
  get 'cart' => 'orders#cart', as: :cart
  get 'ship_order/:id' => 'orders#ship_order', as: :ship_order

  # Set the root url
  root :to => 'home#home'
  
  # Named routes



  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
