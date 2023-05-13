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

  def new
    @current_user = current_user
    @post = Post.new    
  end
  def create
    @current_user = current_user
    @post = Post.create(author: @current_user, title: params[:post][:title], text: params[:post][:text])
    pp @post
    if @post.persisted?
      redirect_to user_path(@post.author_id)
      pp "saved"
    else
      render :new
      pp "Error"
    end
  end
end
