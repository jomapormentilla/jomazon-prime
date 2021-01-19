Rails.application.routes.draw do
  root "welcome#home"
  
  get '/search' => 'welcome#search'
  post '/search' => 'welcome#search'
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  get '/sellers' => 'users#sellers'

  get '/addtocart/:id' => 'products#addtocart', as: "addtocart"

  resources :products
  resources :categories
  resources :ratings, only: [:create]
  resources :reviews, only: [:create]
  resources :comments, only: [:create]
  
  resources :departments, only: [:index] do
    resources :products, only: [:index]
  end
  
  resources :users do
    resources :products, only: [:index, :new]
    resources :carts, only: [:show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
