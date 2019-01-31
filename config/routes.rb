Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks

  devise_for :users
  resources :users, only: %i(show)

  namespace :admin do
    resources :users
  end

end
