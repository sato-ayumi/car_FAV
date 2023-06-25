class RemoveConstraintFromReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :star, :float, null: true
  end
end
