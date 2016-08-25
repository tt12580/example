Rails.application.routes.draw do

  namespace :admin do
    root 'users#index'
    resources :users do
      resources :microposts
    end

  end

  get 'microposts/new'
  get 'microposts/show'
  get 'sessions/new'
  get 'users/new'
  get 'users/show'
  get '/signup',to: 'users#new'
  post '/signup',to: 'users#create'
  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,      only: [:create, :destroy]
  resources :relationships,   only: [:create, :destroy]
  root 'microposts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
