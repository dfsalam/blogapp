class CommentsController < ApplicationController
  def new
    @current_user = current_user
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @current_user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.create(post: @post, author: @current_user, text: params[:comment][:text])
    pp @comment
    if @comment.persisted?
      redirect_to user_path(@post.author_id)
      pp 'saved'
    else
      render :new
      pp 'Error'
    end
  end
end
