Rails.application.routes.draw do
  get '/login' => 'sessions#new', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  get '/auth/beak/callback', to: 'sessions#create'

  resources :tasks do
    collection do
      post :assign
      get :my
    end
    member do
      post :complete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tasks#index'
end
