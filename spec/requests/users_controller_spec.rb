require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  describe 'GET /index' do
    it 'Returns http success' do
      get '/users'
      expect(response.status).to eq(200)
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
    it 'Returns not found' do
      expect { get '/users/789' }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
