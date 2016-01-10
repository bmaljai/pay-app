Rails.application.routes.draw do
  devise_for :users
  root to: "profiles#show"

  resources :pages
  
  resources :profiles

  resources :users
  resources :invoices
  resources :debts
end
