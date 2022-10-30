# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "tasks#index"

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :tasks, only: [:index]
end
