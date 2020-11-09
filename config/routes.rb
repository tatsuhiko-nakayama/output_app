Rails.application.routes.draw do
  root to: 'items#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show] do
    resources :profiles, only: [:edit, :update]
  end

  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  get '/items/hashtag/:name', to: "items#tag"
  get '/items/category/:id', to: "items#category"
end
