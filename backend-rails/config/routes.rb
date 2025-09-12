Rails.application.routes.draw do
  resources :users
  resources :contents, only: [:index, :show]
  resources :resources, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
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
  
  # Rota específica para deletar comentários
  delete '/comments/:id', to: 'comments#destroy'
  
  # Profile routes
  put '/profile/:id/name', to: 'profile#update_name'
  put '/profile/:id/username', to: 'profile#update_username'
  put '/profile/:id/user_type', to: 'profile#update_user_type'
  
  # Admin routes
  namespace :admin do
    post :login, to: 'admin#login'
    get :users, to: 'admin#users_index'
    put 'users/:id', to: 'admin#users_update'
    delete 'users/:id', to: 'admin#users_destroy'
    get :posts, to: 'admin#posts_index'
    delete 'posts/:id', to: 'admin#posts_destroy'
    get :articles, to: 'admin#articles_index'
    post :articles, to: 'admin#articles_create'
    put 'articles/:id', to: 'admin#articles_update'
    delete 'articles/:id', to: 'admin#articles_destroy'
  end
end
