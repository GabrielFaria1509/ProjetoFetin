Rails.application.routes.draw do
  resources :users
  resources :contents, only: [:index, :show]
  resources :resources, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "rails/health#show"
  post "/signup", to: "users#create"
  post "/login", to: "users#login"
  put "/users/:id", to: "users#update"
  patch "/users/:id", to: "users#update"
  delete '/users/:id', to: 'users#destroy', as: 'delete_user'
  post '/users/:id/upload_avatar', to: 'users#upload_avatar'
  
  # Posts routes
  resources :posts, only: [:index, :create, :destroy] do
    collection do
      get :search
    end
    member do
      post :like
      post :save_post
    end
    resources :comments, only: [:index, :create]
  end
  
  # Profile routes
  put '/profile/:id/name', to: 'profile#update_name'
  put '/profile/:id/username', to: 'profile#update_username'
  put '/profile/:id/user_type', to: 'profile#update_user_type'
end
