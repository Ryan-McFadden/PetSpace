Rails.application.routes.draw do
  root 'sessions#home'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "/auth/:provider/callback", to: 'sessions#omni'

  resources :comments
  resources :users do 
    resources :pets, only: [:index]
  end
  resources :pets do 
    resources :comments, only: [:new, :create, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
