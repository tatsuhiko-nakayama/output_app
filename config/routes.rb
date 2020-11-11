Rails.application.routes.draw do
  root to: 'items#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show] do
    resources :profiles, only: [:edit, :update]
    collection do
      get 'search'
    end
  end

  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :relationships, only: [:create, :destroy]
  
  get '/items/hashtag/:name', to: "items#tag"
  get '/items/category/:id', to: "items#category"
  get '/hashtags', to: "tags#search"
  get '/likes/user/:id', to: "likes#index"
  
end