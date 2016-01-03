Rails.application.routes.draw do
  devise_for :users
  root to: "debts#index"
  resources :debts
end
