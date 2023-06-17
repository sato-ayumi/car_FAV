class AddConstraintsToReviews < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reviews, :title, false
    change_column_null :reviews, :body, false
    change_column_null :reviews, :maker, false
    change_column_null :reviews, :user_id, false
    change_column_null :reviews, :star, false
  end
end
