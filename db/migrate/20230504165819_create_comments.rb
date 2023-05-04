class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, index: true, foreign_key: {to_table: :users, primary_key: :authorId}
      t.references :post, index: true, foreign_key: {to_table: :posts, primary_key: :postId}
      t.text :text
      t.datetime :created_at
      t.datetime :updated_at
      self.primary_key = 'commentId'
      t.timestamps
    end
  end
end
