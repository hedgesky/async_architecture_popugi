Rails.application.routes.draw do
  resources :balances, only: :show
  root to: 'dashboard#index'
end
