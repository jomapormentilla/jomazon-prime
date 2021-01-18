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

  resources :categories
  resources :stores
  resources :ratings
  resources :reviews
  resources :comments
  resources :products
  
  resources :departments do
    resources :products, only: [:index]
  end
  
  resources :users do
    resources :products, only: [:index, :new]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
