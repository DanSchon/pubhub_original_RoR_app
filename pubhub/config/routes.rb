Rails.application.routes.draw do
  root to: 'pages#front'
  get '/register', to: "users#new"
  get '/sign_in', to: "sessions#new"

  resources :users, only: [:create]
end
