Rails.application.routes.draw do
  root to: 'pages#front'
  get '/register', to: "users#new"
  get '/sign_in', to: "sessions#new"
  get '/home', to: "pubs#index"
  get '/sign_out', to: "sessions#destroy"

  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :pubs, only: [:new, :create, :show] do 
    resources :reviews, only: [:create]
  end
end
