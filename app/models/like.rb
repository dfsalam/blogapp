class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  after_save :update_post_likes_counter

  private

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
