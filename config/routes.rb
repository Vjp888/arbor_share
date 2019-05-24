Rails.application.routes.draw do
  root 'projects#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  get '/profile', to: 'users#show', as: 'profile'


  namespace :admin do
    resources :projects, only: [:new, :create]
  end

  resources :projects, only: [:show]
end
