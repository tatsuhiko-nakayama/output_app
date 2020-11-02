Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users

  resources :users, only: [:show] do
    resources :profiles, only: [:new, :create, :edit, :update]
  end
end
