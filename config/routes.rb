# frozen_string_literal: true

Rails.application.routes.draw do
  get 'requests/new', to: 'add_requests#new'
  post 'requests/new', to: 'add_requests#create'
  patch 'requests/:id', to: 'add_requests#close'

  get 'sessions/new'
  # URL root should lead to university list
  root 'universities#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/comments/create', to: 'comments#create'
  patch '/comments/:id', to: 'comments#report'
  resources :comments, only: %i[create destroy]

  get '/dashboard/moderator', to: 'static_pages#moderator'
  get '/dashboard/administrator', to: 'static_pages#administrator'
  get '/compare', to: 'static_pages#compare'
  delete '/compare', to: 'static_pages#remove_compare'
  get '/help', to: 'static_pages#help'

  # Only allow index/show actions on universities
  resources :universities, only: %i[index show toggle_favorite], path: '/' do
    get '/edit', to: 'universities#edit'
    patch '/update', to: 'universities#update'
    patch '/', to: 'universities#toggle_favorite'
  end
end
