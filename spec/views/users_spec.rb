require 'rails_helper'

RSpec.describe 'Users index page', type: :feature do
  let!(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:second_user) { User.create(name: 'Lilly', photo: 'https://www.joseivanaguilar.com/wp-content/uploads/2021/03/mujer-696x465.jpg', bio: 'Teacher from Poland.') }
  let!(:first_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my first post') }
  let!(:second_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my second post') }
  let!(:third_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my third post') }
  let!(:fourth_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my fourth post') }
  before do
    Comment.create(post: first_post, author: second_user, text: 'Hi xTom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi xxTom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi xxxTom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi xxxxTom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi xxxxxTom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi xxxxxxTom!')

    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
  end
  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content('Tom')
    expect(page).to have_content('Lilly')
  end

  scenario 'I can see the profile picture for each user.' do
    visit users_path
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    expect(page).to have_css("img[src*='https://www.joseivanaguilar.com/wp-content/uploads/2021/03/mujer-696x465.jpg']")
  end

  scenario 'I can see the number of posts each user has written.' do
    visit users_path
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content('Number of posts: 0')
  end

  scenario 'Clicking on the first user redirects to their show page' do
    visit users_path
    href_link = "/users/#{first_user.id}"
    find("a[href='#{href_link}']").click
    expect(current_path).to eq(user_path(first_user.id))
  end

  scenario 'Clicking on the second user redirects to their show page' do
    visit users_path
    href_link = "/users/#{second_user.id}"
    find("a[href='#{href_link}']").click
    expect(current_path).to eq(user_path(second_user.id))
  end
end
