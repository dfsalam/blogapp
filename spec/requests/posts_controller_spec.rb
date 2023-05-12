require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET /index' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    second_user_id = second_user.id
    it 'Returns http success' do
      get "/users/#{second_user_id}/posts"
      expect(response.status).to eq(200)
    end
    it 'Renders the index template' do
      get "/users/#{second_user_id}/posts"
      expect(response).to render_template(:index)
    end
    it 'Includes the page title' do
      get "/users/#{second_user_id}/posts"
      expect(response.body).to include('Welcome to posts index page')
    end
  end
  describe 'GET /show' do
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    first_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
    second_user_id = second_user.id
    first_post_id = first_post.id
    it 'Returns http success' do
      get "/users/#{second_user_id}/posts/#{first_post_id}"
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      get "/users/#{second_user_id}/posts/#{first_post_id}"
      expect(response).to render_template(:show)
    end
    it 'Includes the page title' do
      get "/users/#{second_user_id}/posts/#{first_post_id}"
      expect(response.body).to include('Welcome to posts show page')
    end
  end
end
