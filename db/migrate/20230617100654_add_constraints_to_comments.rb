class AddConstraintsToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :comment, false
    change_column_null :comments, :user_id, false
    change_column_null :comments, :review_id, false
  end
end
