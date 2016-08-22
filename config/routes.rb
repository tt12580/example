Rails.application.routes.draw do
  get 'microposts/new'

  get 'microposts/show'

  get 'sessions/new'

  get 'users/new'
  get '/signup',to: 'users#new'
  post '/signup',to: 'users#create'
  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  get 'users/show'
  resources :users
  resources :microposts,only: [:create,:destroy]
  root 'microposts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
