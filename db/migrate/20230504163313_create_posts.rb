class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, index: true, foreign_key: {to_table: :users, primary_key: :authorId}
      t.string :title
      t.text :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :comments_counter
      t.integer :likes_counter
      self.primary_key = 'postId'
      t.timestamps
    end
  end
end
