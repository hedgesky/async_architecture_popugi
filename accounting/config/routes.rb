Rails.application.routes.draw do
  post 'finish_day/create', as: :finish_day
  resources :balances, only: :show
  root to: 'dashboard#index'

  get '/login' => 'sessions#new', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  get '/auth/beak/callback', to: 'sessions#create'

  get '/not_authorized' => 'static#not_authorized', as: :not_authorized
end
