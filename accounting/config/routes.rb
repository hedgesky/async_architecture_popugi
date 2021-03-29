Rails.application.routes.draw do
  post 'finish_day/create', as: :finish_day
  resources :balances, only: :show
  root to: 'dashboard#index'
end
