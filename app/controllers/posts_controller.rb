class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
  end

  def show
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
    @post = Post.find(params[:id])
  end
end
