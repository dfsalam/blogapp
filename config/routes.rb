Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :likes, only: [:create], shallow: true
    end
  end

  #To show the comment form
  get '/users/:user_id/posts/:post_id/comment', to: 'comments#new', as: 'new_comment'
  #To save the comment
  post '/users/:user_id/posts/:post_id/comment', to: 'comments#create', as:'user_post_comment'
  #To show the post form
  get '/users/:user_id/post/new', to: 'posts#new', as: 'new_post'
  #To save the post
  post '/users/:user_id/post/new', to: 'posts#create', as:'create_post'
  #To allow users to like post
  # match '/posts/:id/like', to: 'posts#like', via: :post, as: 'like_post'
  
end
