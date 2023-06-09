class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, index: true, foreign_key: {to_table: :users, primary_key: :id}
      t.references :post, index: true, foreign_key: {to_table: :posts, primary_key: :id}
      t.timestamps
    end
  end
end
