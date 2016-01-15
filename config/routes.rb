Rails.application.routes.draw do
  devise_for :users
  # root to: 'pages#landing'
  root to: "profiles#show"

  get '/pages/landing', to: 'pages#landing'
  resources :pages
  
  get '/profiles/recent', to: 'profiles#recent'
  resources :profiles
  resources :users
  resources :invoices
  resources :debts
end
