require 'rails_helper'

describe Post, type: :model do
  describe 'Title presence' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    first_post = Post.create(author: second_user, title: nil, text: 'This is my first post')
    second_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')

    it 'Invalid because does not have title.' do
      expect(first_post).to_not be_valid
    end
    it 'Valid, the title is Hello' do
      expect(second_post).to be_valid
    end
  end

  describe 'Title must not exceed 250 characters.' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    second_post = Post.create(author: second_user,
                              title: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                              xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                              xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                              xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                              xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                              xxxxxxxxxxxxxxxxxxxxxxxxxxxx', text: 'This is my first post')

    it 'Invalid, title size exceed 250 characters' do
      expect(second_post).to_not be_valid
    end
    it 'Valid, title size only has 5 characters.' do
      expect(first_post).to be_valid
    end
  end

  describe 'CommentsCounter must be an integer greater than or equal to zero.' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')

    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    it 'comments_counter=0 valid' do
      first_post.comments_counter = 0
      expect(first_post).to be_valid
    end
    it 'comments_counter=-1 invalid' do
      first_post.comments_counter = -1
      expect(first_post).to_not be_valid
    end
    it 'comments_counter=1 valid' do
      first_post.comments_counter = 1
      expect(first_post).to be_valid
    end
  end
  describe 'LikesCounter must be an integer greater than or equal to zero.' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')

    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    it 'likes_counter=0 valid' do
      first_post.likes_counter = 0
      expect(first_post).to be_valid
    end
    it 'likes_counter=-1 invalid' do
      first_post.likes_counter = -1
      expect(first_post).to_not be_valid
    end
    it 'likes_counter=1 valid' do
      first_post.likes_counter = 1
      expect(first_post).to be_valid
    end
  end
  describe 'Testing methods' do
    let(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
    let(:second_user) { User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }
    let(:first_post) { Post.create(author: first_user, title: 'Hello', text: 'First post') }
    let(:second_post) { Post.create(author: first_user, title: 'Hello', text: 'First post') }
    let(:third_post) { Post.create(author: first_user, title: 'Hello', text: 'First post') }
    let!(:comment1) { Comment.create(post: first_post, author: second_user, text: 'Hi xTom!') }
    let!(:comment2) { Comment.create(post: first_post, author: second_user, text: 'Hi xxTom!') }
    let!(:comment3) { Comment.create(post: first_post, author: second_user, text: 'Hi xxxTom!') }
    let!(:comment4) { Comment.create(post: first_post, author: second_user, text: 'Hi xxxxTom!') }
    let!(:comment5) { Comment.create(post: first_post, author: second_user, text: 'Hi xxxxxTom!') }
    let!(:comment6) { Comment.create(post: first_post, author: second_user, text: 'Hi xxxxxxTom!') }

    describe 'testing recent comments' do
      it 'returns the 6, 5, 4 ,3 and 2 comments' do
        recent_comments = first_post.recent_comments

        expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
        expect(recent_comments.size).to eq(5)
      end

      it 'returns 3, 2 and 1' do
        comment6.destroy
        recent_comments = first_post.recent_comments

        expect(recent_comments).to eq([comment5, comment4, comment3, comment2, comment1])
      end
    end
  end
  describe 'Testing method that updates the posts counter for a user' do
    it 'increments the posts counter by 1' do
      second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Poland.')

      expect do
        Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
      end.to change { second_user.reload.posts_counter }.by(1)
    end
  end
end
