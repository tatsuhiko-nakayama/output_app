Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users
end
