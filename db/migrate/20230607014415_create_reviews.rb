class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.string :maker
      t.integer :user_id
      t.float :star
      t.integer :status
      t.timestamps
    end
  end
end
