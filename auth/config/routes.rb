Rails.application.routes.draw do
  devise_for :auth_admin_accounts
  resources :accounts, except: :show

  use_doorkeeper

  root to: 'accounts#index'
end
