Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :users

  root 'products#index'
end
