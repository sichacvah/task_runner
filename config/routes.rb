Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root "home#index"
  get 'login' => 'sessions#new', as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  resources :registration, only: [:new, :create]
  resources :sessions

  resources :projects do
    get "tasks/tags/:tag", to: 'tasks#index', as: :tag
    resources :tasks do
      member do
        post :new_state
        post :previos_state
      end
    end
  end
end
