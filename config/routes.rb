Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users
  resources :users, only: %i(show)
  root to: 'tasks#index'
  resources :tasks
end
