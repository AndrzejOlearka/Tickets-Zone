Rails.application.routes.draw do
  resources :tickets
  resources :users_integrations
  root 'home#index'
  devise_for :users
end
