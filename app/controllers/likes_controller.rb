class LikesController < ApplicationController
  def create
    @current_user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.create(post: @post, author: @current_user)
    if @like.persisted?
      redirect_back(fallback_location: @post)
      pp 'liked'
    else
      pp 'error'
      redirect_to @post, alert: 'Failed to like the post.'
    end
  end
end
