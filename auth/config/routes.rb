Rails.application.routes.draw do
  devise_for :accounts, controllers: { sessions: 'accounts/sessions' }

  resources :accounts, except: :show do
    get :current, on: :collection
  end

  use_doorkeeper

  get '/not_authorized' => 'static#not_authorized'

  root to: 'static#not_authorized'
end
