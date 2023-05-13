class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
    @post = Post.find(params[:id])
    @comments = @post.all_comments
    @current_user = current_user
  end
end
