Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, except: :show

  use_doorkeeper

  root to: 'accounts#index'
end
