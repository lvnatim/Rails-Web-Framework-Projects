Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  get 'movies/sort/:by', to: "movies#sort"
  resources :actors, except: [:destroy]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'movies#index'
end
