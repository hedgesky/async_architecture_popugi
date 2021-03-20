Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, except: :show do
    get :current, on: :collection
  end

  use_doorkeeper

  root to: 'accounts#index'
end
