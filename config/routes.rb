Rails.application.routes.draw do
  root "home#index"

  resources :registration, only: [:new, :create]
  resources :sessions
  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout
  resources :admin_dashboard

  resources :projects do
    resources :tasks do
      member do
        post :new_state
        post :previos_state
      end
    end
  end
end
