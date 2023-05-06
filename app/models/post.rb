class Post < ApplicationRecord
  attribute :comments_counter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_user_posts_counter
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
