Rails.application.routes.draw do
  root to: 'pages#front'
  get '/register', to: "users#new"
  get '/sign_in', to: "sessions#new"
  get '/home', to: "pubs#index"
  get '/sign_out', to: "sessions#destroy"
  get '/following', to: "relationships#index"

  resources :users, only: [:show, :create]
  resources :sessions, only: [:create]
  resources :pubs, only: [:new, :create, :show] do 
    resources :reviews, only: [:create]
    collection do 
      post '/search', to: 'pubs#search'
    end
  end
  resources :relationships, only: [:create]
end
