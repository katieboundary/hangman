Rails.application.routes.draw do
root to: "games#index"
resources :users
resources :games

get '/login' => 'sessions#new'
post '/login' => 'sessions#create'
get '/logout' => 'sessions#destroy'

get '/signup' => 'users#new'
post '/users' => 'users#create'


end

