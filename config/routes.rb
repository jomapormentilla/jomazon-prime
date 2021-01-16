Rails.application.routes.draw do
  root "welcome#home"
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  resources :categories
  resources :departments
  resources :stores
  resources :ratings
  resources :reviews
  resources :comments
  resources :products
  
  resources :users do
    resources :products, only: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
