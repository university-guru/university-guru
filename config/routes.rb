# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # URL root should lead to university list
  root 'universities#index'

  # Only allow index/show actions on universities
  resources :universities, only: %i[index show], path: '/'
end
