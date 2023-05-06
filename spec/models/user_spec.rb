require 'rails_helper'

describe User, type: :model do
  describe 'Presence of name' do
    first_user = User.create(name: nil, photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    it 'Invalid' do
      expect(first_user).to_not be_valid
    end
    it 'Valid' do
      expect(second_user).to be_valid
    end
  end

  describe 'PostsCounter must be an integer greater than or equal to zero.' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    it 'post_counter=0 valid' do
      second_user.posts_counter = 0
      expect(second_user).to be_valid
    end
    it 'post_counter=-1 invalid' do
      second_user.posts_counter = -1
      expect(second_user).to_not be_valid
    end
    it 'post_counter=1 valid' do
      second_user.posts_counter = 1
      expect(second_user).to be_valid
    end
  end
  describe 'Testing 3 most recent posts' do
    let(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
    let!(:first_post) { Post.create(author: first_user, title: 'Hello', text: 'First post') }
    let!(:second_post) { Post.create(author: first_user, title: 'Hello', text: 'Second post') }
    let!(:third_post) { Post.create(author: first_user, title: 'Hello', text: 'Third post') }
    let!(:fourth_post) { Post.create(author: first_user, title: 'Hello', text: 'Fourth post') }

    describe 'test 1' do
      it 'returns the 4,3 and 2 posts' do
        recent_posts = first_user.recent_posts
       
        expect(recent_posts).to eq([fourth_post, third_post, second_post])
        expect(recent_posts.size).to eq(3)
        
      end
    end
    describe 'test 2' do
      it 'returns 3, 2 and 1' do
        fourth_post.destroy
        recent_posts = first_user.recent_posts

        expect(recent_posts).to eq([third_post, second_post, first_post])
      end
    end
  end
end
