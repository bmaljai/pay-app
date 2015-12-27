Rails.application.routes.draw do
  get "/debts", to: "debts#index"
end
