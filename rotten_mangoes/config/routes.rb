Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  get 'movies/sort/:by', to: "movies#sort"

  namespace :admin do
    resources :users
  end

  get 'spoof/:id', to: "sessions#spoof", as: "spoof"
  delete 'spoof/:id', to: "sessions#end_spoof", as: "end_spoof"
  
  resources :actors, except: [:destroy]
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  root to: 'movies#index'
end
