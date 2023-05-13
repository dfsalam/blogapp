class CommentsController < ApplicationController
  def new
    @current_user = current_user
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end
end