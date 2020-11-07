Rails.application.routes.draw do
  root to: 'items#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show] do
    resources :profiles, only: [:edit, :update]
  end

  resources :items do
    resources :likes, only [:create, :destroy]
  end

end
