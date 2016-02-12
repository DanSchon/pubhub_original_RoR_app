Rails.application.routes.draw do
  root to: 'pages#front'
  get '/register', to: "users#new"
end
