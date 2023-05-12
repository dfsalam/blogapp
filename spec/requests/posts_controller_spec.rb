require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET /index' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    second_user_id = second_user.id    
    it 'Returns http success' do
      get "/users/#{second_user_id}/posts"
      expect(response.status).to eq(200)
    end
    it "renders the index template" do
      get "/users/#{second_user_id}/posts"
      expect(response).to render_template(:index)
    end
    it 'Returns not found' do
      expect { get '/users/789/posts' }.to raise_error(ActiveRecord::RecordNotFound)
    end    
  end
  describe 'GET /show' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    second_user_id = second_user.id
    first_post_id = first_post.id
    it 'Returns http success' do
      get "/users/#{second_user_id}/posts/#{first_post_id}"
      expect(response.status).to eq(200)
    end
    it "renders the show template" do
      get "/users/#{second_user_id}/posts/#{first_post_id}"
      expect(response).to render_template(:show)
    end
    it 'Returns not found' do
      expect { get "/users/789/posts/#{first_post_id}" }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'Returns not found' do
      expect { get "/users/#{second_user_id}/posts/789" }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
