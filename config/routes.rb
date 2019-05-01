# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  # URL root should lead to university list
  root 'universities#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Only allow index/show actions on universities
  resources :universities, only: %i[index show], path: '/'
end
