require 'rails_helper'

RSpec.describe 'Users show page', type: :feature do
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
  scenario 'I can see the profile picture for each user.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_css("img[src*='https://www.joseivanaguilar.com/wp-content/uploads/2021/03/mujer-696x465.jpg']")
  end

  scenario 'I can see the username' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Lilly')
  end

  scenario 'I can see the number of posts each user has written.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'I can see a post title.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Hello')
  end

  scenario "I can see some of the post's body." do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('This is my fourth post')
    expect(page).to have_content('This is my second post')
    expect(page).to have_content('This is my third post')
    expect(page).to have_content('This is my first post')
  end

  scenario 'I can see the first comment on a post.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Hi xxTom!')
  end

  scenario 'I can see how many comments a post has.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Comments: 6')
  end

  scenario 'I can see how many likes a post has.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Likes: 7')
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit user_posts_path(second_user.id)
    expect(page).to have_content('Pagination')
  end

  scenario "When I click a user's post, it redirects me to that post's show page." do
    visit user_posts_path(second_user.id)
    href_link = "/users/#{second_user.id}/posts/#{second_post.id}"
    find("a[href='#{href_link}']").click
    expect(current_path).to eq(user_post_path(second_user.id, second_post.id))
  end
end
