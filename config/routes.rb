Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  #To show the comment form
  get '/users/:user_id/posts/:post_id/comment', to: 'comments#new', as: 'new_comment'
  #To save the comment
  post '/users/:user_id/posts/:post_id/comment', to: 'comments#create', as:'user_post_comment'

  
end
