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
    Comment.create(post: first_post, author: first_user, text: 'Hi xxxxxxTom!')

    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
    Like.create(post: first_post, author: second_user)
  end
  scenario 'I can see a post title.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content('Hello')
  end

  scenario 'I can see who wrote the post.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content(second_user.name)
  end

  scenario 'I can see how many comments the post has.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content('Comments: 6')
  end

  scenario 'I can see how many likes the post has.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content('Likes: 7')
  end

  scenario 'I can see the post body.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content('This is my first post')
  end

  scenario 'I can see the username of each commentor and the comment.' do
    visit user_post_path(second_user.id, first_post.id)
    expect(page).to have_content('Lilly: Hi xxTom!')
    expect(page).to have_content('Lilly: Hi xxxTom!')
    expect(page).to have_content('Lilly: Hi xxxxTom!')
    expect(page).to have_content('Lilly: Hi xxxxxTom!')
    expect(page).to have_content('Tom: Hi xxxxxxTom!')
  end
end
