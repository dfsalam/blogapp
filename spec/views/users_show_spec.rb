require 'rails_helper'

RSpec.describe 'Users show page', type: :feature do
  let!(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:second_user) { User.create(name: 'Lilly', photo: 'https://www.joseivanaguilar.com/wp-content/uploads/2021/03/mujer-696x465.jpg', bio: 'Teacher from Poland.') }
  let!(:first_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my first post') }
  let!(:second_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my second post') }
  let!(:third_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my third post') }
  let!(:fourth_post) { Post.create(author: second_user, title: 'Hello', text: 'This is my fourth post') }

  scenario 'I can see the profile picture for each user.' do
    visit user_path(second_user.id)
    expect(page).to have_css("img[src*='https://www.joseivanaguilar.com/wp-content/uploads/2021/03/mujer-696x465.jpg']")
  end

  scenario 'I can see the username of all other users' do
    visit user_path(second_user.id)
    expect(page).to have_content('Lilly')
  end

  scenario 'I can see the number of posts each user has written.' do
    visit user_path(second_user.id)
    expect(page).to have_content('Number of posts: 4')
  end

  scenario "I can see the user's bio." do
    visit user_path(second_user.id)
    expect(page).to have_content('Teacher from Poland.')
  end

  scenario "I can see the user's first 3 posts." do
    visit user_path(second_user.id)
    expect(page).to have_content('This is my fourth post')
    expect(page).to have_content('This is my second post')
    expect(page).to have_content('This is my third post')
  end

  scenario "I can see a button that lets me view all of a user's posts." do
    visit user_path(second_user.id)
    expect(page).to have_content('See all posts')
  end

  scenario "When I click a user's post, it redirects me to that post's show page." do
    visit user_path(second_user.id)
    href_link = "/users/#{second_user.id}/posts/#{second_post.id}"
    find("a[href='#{href_link}']").click
    expect(current_path).to eq(user_post_path(second_user.id, second_post.id))
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page." do
    visit user_path(second_user.id)
    href_link = "/users/#{second_user.id}/posts"
    find("a[href='#{href_link}']").click
    expect(current_path).to eq(user_posts_path(second_user.id))
  end
end
