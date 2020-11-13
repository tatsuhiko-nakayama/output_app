Rails.application.routes.draw do
  root to: 'items#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:show] do
    get :search, on: :collection
    resource :profile, only: [:edit, :update]
  end

  resources :items do
    get :search, on: :collection
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  
  get '/items/hashtag/:name', to: "items#tag"
  get '/items/category/:id', to: "items#category"
  get '/hashtags', to: "tags#search"
  get '/likes/user/:id', to: "likes#index"
  
end