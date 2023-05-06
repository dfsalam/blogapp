require 'rails_helper'

describe Comment, type: :model do
  describe 'Testing method that updates the comments counter for a post' do
    it 'increments the comments counter by 1' do
      second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Poland.')
      first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
      expect do
        Comment.create(post: first_post, author: second_user, text: 'Hi xTom!' )
      end.to change { first_post.reload.comments_counter }.by(1)
    end
  end
end
