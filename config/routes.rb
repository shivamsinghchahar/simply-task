# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "tasks#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :tasks, except: [:show] do
    patch :mark_as_complete, on: :member
  end
  resources :matrices, only: [:new, :create]
end
