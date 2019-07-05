Rails.application.routes.draw do
  resources :rides
  resources :users
  resources :attractions do
    resources :users
  end
  root to: "users#home"
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
