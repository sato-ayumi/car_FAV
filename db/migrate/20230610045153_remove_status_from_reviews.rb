class RemoveStatusFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :status, :integer
  end
end
