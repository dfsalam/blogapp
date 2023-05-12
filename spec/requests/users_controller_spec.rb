require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /index' do
    it 'Returns http success' do
      get '/users'
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end
    it 'Includes the page title' do
      get '/users'
      expect(response.body).to include('Welcome to users index page')
    end
  end
  describe 'GET /show' do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                             bio: 'Teacher from Mexico.')
    first_user_id = first_user.id
    it 'Returns http success' do
      get "/users/#{first_user_id}"
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      get "/users/#{first_user_id}"
      expect(response).to render_template(:show)
    end
    it 'Includes the page title' do
      get "/users/#{first_user_id}"
      expect(response.body).to include('Welcome to users show page')
    end
  end
end
