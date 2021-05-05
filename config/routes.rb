Rails.application.routes.draw do
  resources :users_integrations
  root 'home#index'
  devise_for :users
end
