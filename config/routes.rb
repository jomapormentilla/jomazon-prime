Rails.application.routes.draw do
  root "welcome#home"

  get '/auth/google_oauth2/callback' => 'sessions#omniauth'
  get '/newuser/account_type' => 'sessions#account_type', as: "account_type"
  post '/newuser/account_type' => 'sessions#account_type', as: "complete_signup"
  
  get '/search' => 'welcome#search'
  post '/search' => 'welcome#search'
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/sellers' => 'users#sellers'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/add-to-cart/:id' => 'carts#addtocart', as: "addtocart"
  post '/remove-item/:id' => 'carts#remove_item', as: "remove_item"
  post '/checkout' => 'carts#checkout', as: "checkout"
  get '/purchases' => 'carts#purchases'

  resources :reviews, only: [:create]
  
  resources :products do
    resources :ratings, only: [:create]
  end
  
  resources :departments, only: [:index] do
    resources :products, only: [:index]
  end
  
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :products, only: [:index, :new]
    resources :carts, only: [:show]
    resources :comments, only: [:create]
  end

  # get '*path' => 'welcome#not_found', as: "not_found"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
