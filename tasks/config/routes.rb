Rails.application.routes.draw do
  resources :tasks do
    collection do
      post :assign
      get :my
    end
    member do
      post :complete
    end
  end

  get :login, to: 'fake_auth#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tasks#index'
end
